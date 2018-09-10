class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :get_user, only: %i(show edit update destroy)
  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t(".success")

      redirect_to @user
    else
      render :new
    end
  end

  def show;end

  def edit;end

  def update
    if @user.update user_params
      flash[:success] = t(".update")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t(".delete_u")
    redirect_to users_url
  end

  private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t(".please")
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def get_user
    @user = User.find_by id: params[:id]
  end
end
