class DirController < ApplicationController
  before_action :dir_id_param, only: [:move, :remove, :name, :publish, :unshare, :show]
  skip_before_action :verify_authenticity_token

  def publish
    directory = Directory.find params[:dir_id]
    directory.link = HashHelper.generate_hash
    directory.save!
    render :json => {result: :ok, hash: directory.link}
  end

  def shared
  end

  def move
    params.require :parent_directory
    directory = Directory.find params[:dir_id]
    directory.directory_id = params[:parent_directory]
    if directory.valid?
      directory.save!
      render :json => Response.response_ok
    else
      render :json => {result: :error, errors: directory.errors},
             :status => 400
    end
  end

  def show
    directories = Directory.where "directory_id=?", params[:dir_id]
    files = UserFile.where "directory_id=?", params[:dir_id]
    render :json => {
        result: :ok,
        files: files.as_json(except: [:user_id, :directory_id]),
        directories: directories.as_json(except: [:user_id, :directory_id])
    }
  end

  def new
    directory = Directory.new params.require(:directory).permit(:name, :directory_id)
    directory.user_id = user_id
    if directory.valid?
      directory.save!
      render :json => {result: :ok, directory: directory.as_json(except: [:user_id, :directory_id])}
    else
      render :json => {result: :error, errors: directory.errors },
             :status => 400
    end
  end

  def remove
    directory = Directory.find(params[:dir_id])
    puts directory.inspect
    if directory.user_files.any? || directory.directories.any?
      render :json => {result: :error, errors: ["The directory is not empty"]},
             :status => 400
    else
      directory.destroy!
      render :json => Response.response_ok
    end
  end

  def name
    params.require(:new_name)
    directory = Directory.find(params[:dir_id])
    directory.name = params[:new_name]
    if directory.valid?
      directory.save!
      render :json => Response.response_ok
    else
      render :json => {result: :error, errors: directory.errors},
             :status => 400
    end
  end

  def unshare
    Directory.find(params[:dir_id]).update! link: nil
    render :json => Response.response_ok
  end

  private
  def dir_id_param
    params.require(:dir_id)
  end
  def user_id
    User.maximum(:id)
  end
end
