class ApplicationController < ActionController::API
  def success_code(response = nil)
    render json: { data: response, success: true }, status: :ok
  end

  def create_code(response = nil)
    render json: { data: response, success: true }, status: :created
  end

  def failure_code(response = nil)
    render json: { data: response, success: false }, status: :bad_request
  end
end
