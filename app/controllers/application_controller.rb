require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  protect_from_forgery with: :exception
  before_action :authenticate_usuario!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  respond_to :html, :xml, :json

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :nome])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :nome])
    end

    def empresa_atual
      @empresa_atual ||= current_usuario.empresa
    end

    def current_ability
      @current_ability ||= Ability.new(current_usuario)
    end

    def session_usuario
      if session[:usuario_id]
        @usuario ||= Usuario.retornar_objeto_pelo_id(session[:usuario_id])
      end
    end
end
