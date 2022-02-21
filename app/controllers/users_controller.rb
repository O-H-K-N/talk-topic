class UsersController < ApplicationController
  skip_before_action :require_login
  # before_action :set_user, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.sign_up_success')
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :account_name,
      :password,
      :password_confirmation
    )
  end
end
