class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate_user!
  after_action :create_cart, only: :create

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    if params[:email].present?
      @users = User.where("email ILIKE ?", "%#{params[:email]}%").where.not(id: current_user.id)
    else
      @users = []
    end

    @user = current_user
  end

  def remove_friend
    friend = User.find(params[:friend_id])
    current_user.friends.destroy(friend) # Remove the friend from the list

    redirect_to user_path(current_user), notice: 'Friend removed successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def create_cart
    current_user.create_cart
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end
end
