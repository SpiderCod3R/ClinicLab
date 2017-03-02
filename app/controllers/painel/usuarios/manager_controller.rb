class Painel::Usuarios::ManagerController < Support::InsideController
  before_action :find_empresa, except: [:create, :update_password, :add_permissions, :save_permissions]

  respond_to :html, :js, :xml, :json

  def create
    if params[:usuario]
      @user = Gclinic::User.new_by(params[:usuario]["0"])
      @user.empresa_id  = current_user.environment_id
      @user.environment = current_user.environment
    end

    if params[:usuario_permissoes]
      @user.import_permissoes(params[:usuario_permissoes])
    end

    if @user.save
      respond_to &:json
    end
  end

  def update
    if user_signed_in?
      @user = Gclinic::User.find(params[:id])
      @user.update_without_password(user_params)
    end
    respond_to &:js
  end

  def add_permissions
    @user = Gclinic::User.find(params[:usuario_id])
    @empresa_permissoes = @user.verify_permissions_not_added
  end

  def save_permissions
    @model = Gclinic::Model.find_by(model_class: "Agenda")

    if params[:usuario]
      @user = Gclinic::User.find(params[:usuario]["0"]["usuario_id"])
    end

    @old_user_model = @user.user_models.find_by(model: @model)


    if params[:usuario_permissoes]
      @user.import_permissoes(params[:usuario_permissoes])
    end

    if @user.save(validate: false)
      if !@old_user_model.nil?
        @agenda_permissao = AgendaPermissao.find_by user_model_id: @old_user_model.id
        if !@agenda_permissao.nil?
          @new_user_model=@user.user_models.find_by(model_id: @model.id)
          @agenda_permissao.update_attributes(user_model_id: @new_user_model.id)
        end
      end
      respond_to &:json
    end
  end

  def destroy
    
  end

  private
    def find_empresa
      @empresa = Empresa.friendly.find(params[:empresa_id])
    end

    def user_params
      params.require(:gclinic_user).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
