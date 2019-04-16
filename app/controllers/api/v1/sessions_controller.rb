class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { api_key: user.api_key }, status: 200
    else
      render json: {
                    error: "Email or password invalid",
                  }, status: :bad_request
    end
  end
end
