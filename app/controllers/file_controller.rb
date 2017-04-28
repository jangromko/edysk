require 'json'
require 'securerandom'
class FileController < ApplicationController
  #if you want to change a file, you need to have its id
  before_action :file_id_param, only:  [:name, :move, :copy,:remove, :unshare, :publish]
  skip_before_action :verify_authenticity_token

  def publish
    hash = SecureRandom.hex
    UserFile.find(params[:file_id]).update(link: hash)
    render :json => {
        result: :ok,
        hash: hash
    }
  end

  def download
  end

  def shared
    render :json => {result: :ok, files: User.find(user_id).shared_files.to_a.map{
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
    UserFile.find(params[:file_id]).destroy!
    render :json => Response.response_ok
  end

  def name
    # the new name is necessary to change the name, innit?
    params.require(:new_name)

    file = UserFile.find(params[:file_id])
    file.name = params[:new_name]
    if file.valid?
      file.save
      render :json => Response.response_ok
    else
      render :json => {result: :error, errors: file.errors}
    end

  end

  def share
    params.require(:user_id)
    shared_file = SharedFile.new()
    shared_file.user_file = UserFile.find(params[:file_id])
    shared_file.user = User.find(user_id)
    if shared_file.valid?
      shared_file.save
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
        file.save
        render :json => Response.response_ok
      else
        render :json => {response: :error, errors: file.errors}
      end
    end
  end

  def copy
    UserFile.transaction do
      UserFile.find(params[:file_id]).dup.save
      render :json => Response.response_ok
    end
  end

  def upload
  end

  def unshare
    UserFile.find(params[:file_id]).update(link: nil)
    render :json => Response.response_ok
  end

  def file_id_param
    params.require(:file_id)
  end

  private
  def user_id
    1
  end
end
