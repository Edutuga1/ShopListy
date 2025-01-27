class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user

    # Check if the current password is correct
    if @user.valid_password?(params[:user][:current_password])
      # Update user attributes
      if @user.update(user_params)
        redirect_to settings_path, notice: 'Your settings have been updated successfully.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Add an error if the current password is invalid
      @user.errors.add(:current_password, 'is incorrect')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :notifications_enabled)
  end
end
