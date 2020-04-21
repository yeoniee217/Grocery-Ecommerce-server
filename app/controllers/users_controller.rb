class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ["No users found"]
      }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: {
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: ["User not found"]
      }
    end
  end

  def create
    @user = User.new(email:                 params[:email],
                     password:              params[:password],
                     password_confirmation: params[:password_confirmation],
                     first_name:            params[:firstName],
                     last_name:             params[:lastName],
                     address:               params[:address],
                     province_id:           params[:provinceID])
    if @user.save
      login!
      render json: {
        status: :created,
        user:   @user
      }
    else
      render json: {
        status: 500,
        errors: @user.errors.full_messages
      }
    end
  end

  private

  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation)
  # end
end
