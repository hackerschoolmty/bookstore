class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include? params[:locale]
        I18n.locale = params[:locale]
      else
        flash[:alert] = "#{params[:locale]} " + t(:not_available)
      end
    end
  end
end
