module Admin
  class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    def index
      @users = User.all
    end

    def toggle_admin
      user = User.find(params[:id])
      if user.admin?
        user.update(admin: false)
        flash[:notice] = "#{user.name} is no longer an admin."
      else
        user.update(admin: true)
        flash[:notice] = "#{user.name} is now an admin."
      end
      redirect_to admin_users_path
    end

    def destroy
      user = User.find(params[:id])
      if user != current_user
        user.destroy
        flash[:notice] = "#{user.name} has been deleted."
      else
        flash[:alert] = "You cannot delete your own account."
      end
      redirect_to admin_users_path
    end

    def reset_password
      user = User.find(params[:id])
      new_password = SecureRandom.hex(8)  # Generate a random password
      user.update(password: new_password, password_confirmation: new_password)
      flash[:notice] = "#{user.name}'s password has been reset to #{new_password}."
      redirect_to admin_users_path
    end

    private

    def authenticate_admin!
      redirect_to root_path, alert: "Access denied." unless current_user&.admin?
    end
  end
end
