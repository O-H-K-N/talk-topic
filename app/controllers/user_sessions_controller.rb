class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: t('.login_success')
    else
      flash.now[:danger] = t('.login_error')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.logout_success')
  end
end
