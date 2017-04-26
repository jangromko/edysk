require 'json'
class FileController < ApplicationController
  #if you want to change a file, you need to have its id
  before_action :file_id_param, only:  [:name, :move, :copy,:remove]
  skip_before_action :verify_authenticity_token
  def download
  end

  def shared
  end

  def remove
    UserFile.find(params[:file_id]).destroy!
    render :json => :ok
  end

  def name
    # the new name is necessary to change the name, innit?
    params.require(:new_name)

    UserFile.find(params[:file_id]).update(name: params[:new_name])
    render :json => Response.response_ok
  end

  def share

  end

  def move
    params.require(:dir_id)
    Directory.transaction do
      directory = Directory.find_by_id(params[:dir_id])
      if directory.nil?
        render :json => { result: :error, error: "No such a directory"}
      else
        file = UserFile.find(params[:file_id])
        UserFile.find(params[:file_id]).update(directory_id: params[:dir_id])
        render :json => Response.response_ok
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
  end

  def file_id_param
    params.require(:file_id)
  end
end
