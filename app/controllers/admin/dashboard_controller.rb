module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def index
      # Admin dashboard logic, e.g., fetch stats or recent activity
      @user_count = User.count
      @admin_count = User.where(admin: true).count
    end

    private

    def authenticate_admin!
      unless current_user&.admin?
        redirect_to root_path, alert: "Access denied."
      end
    end
  end
end
