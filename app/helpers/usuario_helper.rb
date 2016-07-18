module UsuarioHelper
  def funcionario?
    if usuario_signed_in?
      current_usuario.funcionario?
    end
  end

  def administrador?
    if usuario_signed_in?
      current_usuario.admin?
    end
  end

  def gsuper?
    if usuario_signed_in?
      current_usuario.super?
    end
  end
end
