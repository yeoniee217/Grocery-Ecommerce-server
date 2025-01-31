class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      login!
      render json: {
        logged_in: true,
        user:      @user
      }
    else
      render json: {
        status: 401,
        errors: ["No such user", "Verify credentials and try again or signup"]
      }
    end
  end

  def is_logged_in?
    if logged_in? && current_user
      # @logged_in = { logged_in: true }
      # @user = current_user
      # render :show
      puts current_user.province_id
      @province = Province.find(current_user.province_id)
      render json: {
        logged_in: true,
        user:      current_user,
        province:  @province
      }
    else
      render json: {
        logged_in: false,
        message:   "No such user"
      }
    end
  end

  def destroy
    logout!
    render json: {
      status:     200,
      logged_out: true
    }
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
