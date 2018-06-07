class ApplicationController < ActionController::Base

  before_action :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :bio, :location, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :bio, :location, :avatar])
  end
end
