class Empresas::FuncionariosController < ApplicationController
  load_and_authorize_resource :empresa
  load_and_authorize_resource :usuario, through: :empresa
  include Wicked::Wizard
  steps *Usuario.form_steps

  def show
    if params[:usuario_id]
      @usuario = Usuario.find(params[:usuario_id])
    else
      @usuario = Usuario.find(session_usuario)
    end
    @usuario.usuario_permissao_empresas.build
    render_wizard
  end

  def update
    @usuario = Usuario.retornar_objeto_pelo_id(session_usuario)
    @usuario.update(usuario_params)
    render_wizard @usuario
  end

  def usuario_params
    params.require(:usuario).permit(:nome, :email, :password, :funcao_id, :empresa_id, 
                  usuario_permissao_empresas_attributes: [:id, :usuario_id, :cadastrar, :editar, :excluir, :visualizar ,:permissao_empresa_id], 
                  :usuario_permissao_empresa_ids =>[],
                  :permissao_empresa_ids =>[])
  end
end
