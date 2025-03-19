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
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])

    friendship1 = Friendship.find_by(user_id: @user.id, friend_id: @friend.id, status: 'accepted')
    friendship2 = Friendship.find_by(user_id: @friend.id, friend_id: @user.id, status: 'accepted')

    if friendship1
      friendship1.destroy
      flash[:notice] = "Friendship removed"
    elsif friendship2
      friendship2.destroy
      flash[:notice] = "Friendship removed"
    else
      flash[:alert] = "Friendship not found"
    end
    redirect_to profile_path(@user)
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
