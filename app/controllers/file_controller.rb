require 'json'
require 'securerandom'
require 'copy_carrierwave_file'
class FileController < ApplicationController
  #if you want to change a file, you need to have its id
  before_action :file_id_param, only: [:name, :move, :copy, :remove, :unshare, :publish, :download]
  before_action :authorization, except: [:shared_file]
  skip_before_action :verify_authenticity_token

  def publish
    file = UserFile.find(params[:file_id])
    if file.link.nil?
      hash = HashHelper.generate_hash
      file.update!(link: hash)
    end
    render :json => {
        response: :ok,
        link: file_shared_url+"/"+file.link
    }
  end

  def download
    file = UserFile.find params[:file_id]
    send_file file.file.current_path,
              filename: file.name
  end

  def shared_file
    file = UserFile.find_by_link!(params.require(:hash))
    send_file file.file.current_path,
              filename: file.name
  end

  def shared
    render :json => {response: :ok, files: User.find(user_id).shared_files.to_a.map {
        |shared_file|
      user_file = shared_file.user_file
      {
          id: user_file.id,
          name: user_file.name,
          user: user_file.user.login
      }
    }}
  end

  def remove
    User.transaction do
      file = UserFile.find(params[:file_id])
      user = User.find(user_id).lock!(true)
      user.used_size -= file.size
      user.save!
      file.destroy!
    end
    user = User.find(user_id)
    render :json => { response: :ok, space: space}
  end

  def name
    # the new name is necessary to change the name, innit?
    params.require(:new_name)

    file = UserFile.find(params[:file_id])
    file.name = params[:new_name]
    if file.valid?
      file.save!
      render :json => {response: :ok, file: file.as_json}
    else
      render :json => {response: :error, errors: file.errors}
    end

  end

  def share
    params.require(:user_id)
    shared_file = SharedFile.new()
    shared_file.user_file = UserFile.find(params[:file_id])
    shared_file.user = User.find(user_id)
    if shared_file.valid?
      shared_file.save!
      render :json => Response.response_ok
    else
      render :json => {response: :error, errors: shared_file.errors}
    end


  end

  def move
    params.require(:dir_id)
    Directory.transaction do
      directory = Directory.find_by_id(params[:dir_id])
      file = UserFile.find(params[:file_id])
      file.directory = directory
      if file.valid?
        file.save!
        render :json => {response: :ok, file: file.as_json}
      else
        render :json => {response: :error, errors: file.errors}
      end
    end
  end

  def copy
    params.require(:dir_id)
    UserFile.transaction do
      file = UserFile.find(params[:file_id])
      copied_file = file.deep_dup
      CopyCarrierwaveFile::CopyFileService.new(file, copied_file, :file)
      copied_file.directory_id = params[:dir_id]
      copied_file.save!
      render :json => {response: :ok, file: file}
    end
  end

  def upload
    file = UserFile.new(params.require(:file).permit(:name, :directory_id, :file))
    file.user_id = user_id
    User.transaction do
      user = User.find(user_id).lock!(true)
      if user.used_size + file.file.size > user.account_type.space
        render :json => {response: :error, errors: ["Zbyt duży plik"]},
               :status => 400
        return
      else
        user.used_size += file.file.size
        file.size = file.file.size
        file.extension = file.name.split('.')[-1].downcase
        i = 0
        while i < 5 && !file.valid?
          file.name += "(1)"
          i += 1
        end
        file.save!
        user.save!
      end
    end
    render :json => {response: :ok, file: file.as_json(except: [:user_id, :file_id]), space: space }
  end

  def unshare
    UserFile.find(params[:file_id]).update!(link: nil)
    render :json => Response.response_ok
  end

  def file_id_param
    params.require(:file_id)
    raise NotPermitted unless UserFile.find(params[:file_id]).user_id.eql? user_id
  end

  def space
    user = User.find(user_id)
    {
        used: user.used_size,
        max_space: user.account_type.space
    }
  end
  def authorization
    raise NotPermitted if user_id.nil?
  end


  def extensions_list
      files = UserFile.where("user_id=?", user_id).group(:extension).sum(:size)
      sum = files.values.sum
    render :json => {response: :ok, chart: {
        labels: files.keys,
        series: files.values.map do
          |val| (100*val.to_f/sum).to_i
        end
    }}
  end
  private
  def user_id
    session[:user_id]
  end
end
