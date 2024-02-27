class ApplicationController < ActionController::API
  before_action :authenticate_request

  $drive_type = ENV['SERVICE_TYPE']
  $file_path = ENV['FILE_PATH']
  rescue_from StandardError do |e|
    render json: { error: e.message }, status: :internal_server_error
  end
  def store
    @drive = DriveFactory.create_drive($drive_type)
    result = @drive.store_data(id = store_params[:id],blob = store_params[:data])
    if result[:success]
      render json: result
    else
      render json: { error: result[:error] }, status: 400
    end
  end

  def get_blob
    @drive = DriveFactory.create_drive($drive_type)
    result = @drive.get_file_data(params[:id])
    if result[:success]
      render json: result[:data].to_json
    else
      render json:  result, status: 400
    end
  end

  private
  def store_params
    params.require(:drive).permit(:id,:data)
  end

  private
  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last
    unless token == "valid_token"
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
end
