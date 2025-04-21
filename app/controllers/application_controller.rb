class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  helper_method :current_cart
  protect_from_forgery with: :exception, unless: -> { request.format.json? || request.path =~ /^\/users\/auth/ }
  skip_before_action :verify_authenticity_token, if: -> { request.path =~ /^\/users\/auth/ }

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

  def set_locale
    requested_locale = params[:locale]&.split('?')&.first
    I18n.locale = if requested_locale.present? && I18n.available_locales.include?(requested_locale.to_sym)
                    requested_locale
                  else
                    session[:locale] || I18n.default_locale.to_s
                  end
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
