class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart

  include Devise::Controllers::Helpers

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_out_path_for(_)
    root_path
  end

  def current_cart
    @current_cart ||= Cart.find_or_create_by(user_id: current_user.id)
  end
end
