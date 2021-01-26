class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find_by id: params[:id]
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t "welcome_to_the_sample_app"
      redirect_to @user
      log_in @user
    else
      render :new
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
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
