class SessionsController < ApplicationController
  before_action :load_user , only: %i(create)

  def create
    if @user.try(:authenticate, params[:session][:password])
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash[:danger] = t "error_find_user"
    redirect_to root_path
  end
end
