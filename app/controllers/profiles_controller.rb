class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def show
    @user = current_user
  end

  def edit
    # @user is set by set_user
  end

  def update
    @user = current_user

    # Filter out password fields if they are blank
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      clean_params = user_params.except(:password, :password_confirmation)
    else
      clean_params = user_params
    end

    if @user.update(clean_params.except(:user_photo))
      if params[:user][:user_photo].present?
        @user.user_photo.attach(params[:user][:user_photo])
        puts @user.user_photo.attached? # Debug line to ensure attachment happens
      end

      respond_to do |format|
        format.html { redirect_to profile_path, notice: 'Profile was successfully updated.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('profile', partial: 'profile', locals: { user: @user }) }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('profile', partial: 'profile', locals: { user: @user }) }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_photo, :password, :password_confirmation)
  end
end
