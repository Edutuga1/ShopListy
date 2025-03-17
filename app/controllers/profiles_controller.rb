class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]
  before_action :set_recipe, only: [:edit, :update]

  def show
    @user = current_user
  end

  def edit
    # @user is set by set_user
    # @recipe is set by set_recipe
  end

  def update
    @user = current_user

    # Filter out password fields if they are blank
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      clean_params = user_params.except(:password, :password_confirmation)
    else
      clean_params = user_params
    end

    # Ensure the favorite recipe link has a scheme (http:// or https://)
    if params[:user][:favorite_recipe] && params[:user][:favorite_recipe][:link].present?
      link = params[:user][:favorite_recipe][:link].strip # Trim whitespace

      # Prepend https:// if no scheme is present
      unless link =~ /\Ahttps?:\/\// # Check if it starts with http:// or https://
        link = "https://#{link}"
      end

      # Directly update the params with the modified link
      params[:user][:favorite_recipe][:link] = link
    end

    # Start updating the user
    if @user.update(clean_params.except(:user_photo))
      # If user photo is present, handle attachment
      if params[:user][:user_photo].present?
        image = params[:user][:user_photo]
        io = MiniMagick::Image.read(image.tempfile)
        io.resize "1024x1024"
        io.strip
        image.tempfile.rewind
        @user.user_photo.attach(io: image.tempfile, filename: image.original_filename)
        @user.save!
      end

      # Update the favorite recipe if it was provided in the form
      if params[:user][:favorite_recipe]
        @user.favorite_recipe.update(params[:user][:favorite_recipe].permit(:title, :link, :description))
      end

      # Respond to the request (success)
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Profile updated successfully.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('profile', partial: 'profile', locals: { user: @user }) }
      end
    else
      # If update failed, render the edit form again
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

  def set_recipe
    @recipe = @user.favorite_recipe || @user.build_favorite_recipe
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_photo, :about_me, :password, :password_confirmation)
  end

  def favorite_recipe_params
    params.require(:user).permit(favorite_recipe: [:title, :link, :description])[:favorite_recipe] || {}
  end
end
