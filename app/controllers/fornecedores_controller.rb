class FornecedoresController < Support::InsideController
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_fornecedor, only: [:show, :edit, :update, :destroy]

  def index
    @search = Fornecedor.where(empresa: current_user.empresa).ransack(params[:q])
    @fornecedores = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    respond_with(@fornecedor)
  end

  def new
    @fornecedor = current_user.empresa.fornecedores.build
    respond_with(@fornecedor)
  end

  def edit
  end

  def create
    @fornecedor = current_user.empresa.fornecedores.build(fornecedor_params)
    if @fornecedor.save
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: @fornecedor.nome)
      redirect_to new_empresa_fornecedores_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Fornecedor")
      render :new
    end
  end

  def update
    if @fornecedor.update(fornecedor_params)
      respond_with([current_user.empresa, @fornecedor])
    else
      render :edit
    end
  end

  def destroy
    @fornecedor.destroy
    respond_with(@fornecedor)
  end

  private
    def set_fornecedor
      @fornecedor = Fornecedor.find(params[:id])
    end

    def set_estados
      @estados = Estado.pelo_nome
    end

    def fornecedor_params
      params.require(:fornecedor).permit(:status, :nome, :cpf, :cnpj, :email, :telefone, :celular, :endereco, :complemento, :bairro, :estado_id, :cidade_id, :documento, :empresa_id)
    end
end
