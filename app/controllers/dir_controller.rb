class DirController < ApplicationController
  before_action :authorization
  before_action :dir_id_param, only: [:move, :remove, :name, :publish, :unshare, :show]

  skip_before_action :verify_authenticity_token

  def publish
    directory = Directory.find params[:dir_id]
    directory.link = HashHelper.generate_hash
    directory.save!
    render :json => {response: :ok, hash: directory.link}
  end

  def authorization
    raise NotPermitted if user_id.nil?
  end

  def shared
  end

  def move
    params.require :parent_directory
    directory = Directory.find params[:dir_id]
    directory.directory_id = params[:parent_directory]
    directory_id = params[:parent_directory]
    ids = (Directory.join_recursive do
      start_with(directory_id: directory_id)
      .connect_by(directory_id: :id)
    end).map(&:id)
    if ids.include? params[:dir_id]
      render :json => { response: :error, errors: ["Nie możesz przenieść katalogu do jego potomka"]},
             :status => 400
    elsif directory.valid?
      directory.save!
      render :json => {response: :ok, directory: directory.as_json}
    else
      render :json => {response: :error, errors: directory.errors},
             :status => 400
    end
  end

  def show
    directories = Directory.where "directory_id=?", params[:dir_id]
    files = UserFile.where "directory_id=?", params[:dir_id]
    render :json => {
        response: :ok,
        files: files.as_json(except: [:user_id, :directory_id]),
        directories: directories.as_json(except: [:user_id, :directory_id])
    }
  end

  def new
    directory = Directory.new params.require(:directory).permit(:name, :directory_id)
    directory.user_id = user_id
    if directory.valid?
      directory.save!
      render :json => {response: :ok, directory: directory.as_json(except: [:user_id, :directory_id])}
    else
      render :json => {response: :error, errors: directory.errors },
             :status => 400
    end
  end

  def remove
    directory = Directory.find(params[:dir_id])
    if directory.user_files.any? || directory.directories.any?
      render :json => {response: :error, errors: ["Katalog nie jest pusty"]},
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
      render :json => {response: :ok, directory: directory.as_json(except: [:user_id, :directory_id])}
    else
      render :json => {response: :error, errors: directory.errors},
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
    raise NotPermitted unless Directory.find(params[:dir_id]).user_id.eql? user_id
  end
  def user_id
    session[:user_id]
  end
end
