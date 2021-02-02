class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("email_sent_with_password_reset_instructions")
      redirect_to root_url
    else
      flash.now[:danger] = t("email_address_not_found")
      render :new
    end
  end

  def update
    if user_params[:password].empty?
      flash[:warning] = t("please_enter_password")
    elsif @user.update_attributes user_params
      redirect_to login_path
      flash[:success] = t("updated")
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end
  def valid_user
    return if (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
    redirect_to root_url
  end
end
