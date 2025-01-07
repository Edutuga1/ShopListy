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
    if favorite_recipe_params[:link].present?
      link = favorite_recipe_params[:link]

      # Debugging the original link before modification
      Rails.logger.debug("Original Link: #{link}")

      # Check if the link has no scheme (http or https) and prepend https:// if needed
      unless link =~ /\Ahttps?:\/\// # Check if it starts with http:// or https://
        link = "https://#{link}" # Prepend https:// if no scheme is present
      end

      # Debugging the modified link
      Rails.logger.debug("Modified Link: #{link}")

      # Update the favorite_recipe_params with the modified link
      favorite_recipe_params[:link] = link
    end

    # Update user profile information
    if @user.update(clean_params.except(:user_photo))
      # Attach the profile photo if it's present
      if params[:user][:user_photo].present?
        @user.user_photo.attach(params[:user][:user_photo])
      end

      # Update the favorite recipe if it was provided in the form
      if favorite_recipe_params[:title].present? || favorite_recipe_params[:link].present? || favorite_recipe_params[:description].present?
        if @user.favorite_recipe.update(favorite_recipe_params)
          Rails.logger.debug("Favorite recipe updated successfully")
        else
          Rails.logger.debug("Error updating favorite recipe")
        end
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

  def set_recipe
    @recipe = @user.favorite_recipe || @user.build_favorite_recipe
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_photo, :about_me, :password, :password_confirmation)
  end

  # Permit the favorite recipe parameters for updating the favorite recipe
  def favorite_recipe_params
    params.require(:user).permit(favorite_recipe: [:title, :link, :description])[:favorite_recipe] || {}
  end
end
