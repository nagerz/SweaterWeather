class Api::V1::BaseController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session

  def authenticate!
    four_oh_four unless User.find_by(api_key: params[:api_key])
  end

  def four_oh_four
    render json: "Unauthorized".to_json, status: 401
  end
end
