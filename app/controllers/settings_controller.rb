class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user

    # Only update password if it's present
    if user_params[:password].present? || user_params[:password_confirmation].present?
      # Validate the current password before updating (if password fields are provided)
      if @user.valid_password?(user_params[:current_password]) # Check current password
        @user.password = user_params[:password]
        @user.password_confirmation = user_params[:password_confirmation]
      else
        @user.errors.add(:current_password, 'is incorrect')
        render :show, status: :unprocessable_entity and return
      end
    else
      # Remove password fields if no password is provided
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    # Update the user (including email, notifications, etc.)
    if @user.update(user_params)
      # Redirect back to settings page to reload
      redirect_to settings_path, notice: 'Settings updated successfully.'
    else
      render :show
    end 
  end


  private

  # Use this method when updating with or without password
  def user_params
    # If password fields are present, allow current password as well
    if params[:user][:password].present? || params[:user][:password_confirmation].present?
      user_params_with_password
    else
      user_params_without_password
    end
  end

  def user_params_with_password
    # Allow current_password, password, and password_confirmation if password change is happening
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :notifications_enabled)
  end

  def user_params_without_password
    # Allow only name, email, and notifications_enabled if no password change
    params.require(:user).permit(:name, :email, :notifications_enabled)
  end
end
