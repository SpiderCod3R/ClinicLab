class Painel::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
  end

=begin
  Atenção!
  O metodo a seguir é excluisivamente para adicionar permissoes
  à uma empresa.
=end
  def import_permissoes_to_company
    @environment = Gclinic::Environment.find(params[:gclinic_environment][:environment_id])
    if params[:check_all]
      if @environment.import_all_models
        flash[:info] = "Todas Permissoes vinculadas com sucesso."
      else
        flash[:warning] = "As Permissões já existem e não podem ser adicionadas novamente!"
      end
    elsif params[:gclinic_environment]
      if @environment.import_models(params[:gclinic_environment])
        flash[:success] = "Permissões vinculadas com sucesso."
      else
        flash[:warning] = "Não foi possivel adicionar a permissão. Talvez ela já exista!"
      end
    end
    redirect_back(fallback_location: @environment)
  end

=begin
  Metodo para adicionar novos administradores
  diretamente do painel administrativo
=end
  def new_company_admin
    @empresa = Painel::Empresa.find(params[:empresa_id])
    @usuario = Painel::Usuario.new
  end

  def create_admin
    @empresa = Painel::Empresa.find(params[:empresa_id])
    @usuario = Painel::Usuario.new(usuario_params)
    @usuario.empresa_id = @empresa.id
    @usuario.admin = true
    if @usuario.save
      flash[:notice] = "Novo administrador criado com sucesso."
      redirect_to painel_empresa_path(@empresa)
    else
      render :new_company_admin
      flash[:error] = "Não foi possivel criar o administrador"
    end
  end


=begin
  ATENÇÃO
  O método a seguir é unicamente para remover os administradores
  da empresa diretamente do painel administrativo
=end
  def remove_admin
    @usuario = Painel::Usuario.find(params[:usuario_id])
    @empresa = @usuario.empresa
    if @usuario.destroy
      flash[:info] = "Usuário removido com Sucesso"
      redirect_to painel_empresa_path(@empresa)
    else
      flash[:error] = "Não foi possivel remover o administrador!"
    end
  end

=begin
  ATENÇÃO TRIPLICADA AQUI!
  O METODO A SEGUIR IRÁ REMOVER PERMISSAO DA EMPRESA
  CUIDADO AO MANUSEAR ISTO SIGNIFICA REMOVER TANTO DA
  EMPRESA QUANTO DOS USUARIOS AO QUAL A ESTA ESTÃO VINCULADOS
=end

  def remover_permissao_empresa_usaurio
    @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    @empresa_permissao = Painel::EmpresaPermissao.find_by(empresa_id: @empresa.id, permissao_id: params[:permissao_id])
    @empresa.funcionarios.each do |usuario|
      @usuario_permissao = Painel::UsuarioPermissao.find_by(permissao_id: params[:permissao_id], usuario_id: usuario.id)
      unless @usuario_permissao.nil?
        @usuario_permissao.destroy
      end
    end
    @empresa_permissao.destroy
    redirect_to painel_empresa_path(@empresa)
  end

  private
    def resource_params
      params.require(:empresa_permissao).permit(:empresa_id, permissao_ids: [])
    end

    def usuario_params
      params.require(:painel_usuario).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
