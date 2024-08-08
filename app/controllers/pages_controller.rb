class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      @user = current_user
      @welcome_message = "Welcome back, #{@user.name}!"
    else
      @welcome_message = "Welcome to our site! Please sign up or log in."
    end
  end

  def dashboard
    @user = current_user
    @welcome_message = "Welcome back, #{@user.name}!"
  end
end
