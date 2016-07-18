require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
  end


  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} tradução não disponível"
        logger.error flash.now[:notice]
      end
      return unless params[:locale]
    end
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :nome])
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username, :nome])
  # end

  def default_url_options(options = {})
    {locale: I18n.locale}
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
