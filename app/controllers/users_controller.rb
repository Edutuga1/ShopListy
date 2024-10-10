class UsersController < ApplicationController
  before_action :set_user
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

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def create_cart
    current_user.create_cart
  end

  def set_user
    @user = User.find(params[:id]) # Check that this line correctly finds the user
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end
end
