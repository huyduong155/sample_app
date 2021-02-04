class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find_by id: params[:id]
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = t("profile_updated")
      redirect_to @user
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t("please_check_your_email_to_activate_your_account")
      redirect_to root_url
    else
      render :new
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t("please_log_in")
      redirect_to login_url
    end
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t("user_deleted")
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
