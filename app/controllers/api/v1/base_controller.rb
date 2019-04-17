class Api::V1::BaseController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session

  def four_oh_four
    render json: "Unauthorized".to_json, status: 401
  end
end
