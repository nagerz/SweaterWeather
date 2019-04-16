class Api::V1::UsersController < Api::V1::BaseController
  def create
    @user = User.new(user_params)
    if @user.save
      api_key = SecureRandom.hex
      @user.update(api_key: api_key)
      render json: {api_key: api_key}, status: 201
    else
      render json: {
                    error: "Bad Registration Credentials",
                  }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
