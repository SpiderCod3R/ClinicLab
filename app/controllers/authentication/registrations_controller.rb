class Authentication::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_action :authenticate_scope!, :only => [:edit, :update, :destroy, :show]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  private

  def sign_up_params
    params.require(:usuario).permit(:username, :nome, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:usuario).permit(:username, :nome, :email, :password, :password_confirmation, :current_password)
  end
end
