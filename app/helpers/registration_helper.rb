module RegistrationHelper
  def show_admin_common_fields_for(user)
    render 'empresas/usuarios/partials/admin_common_fields', {f: user}
  end

  def show_user_common_fields_for(user)
    render 'empresas/usuarios/partials/user_common_fields', {f: user}
  end
end
