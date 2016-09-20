class FornecedoresController < ApplicationController
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_fornecedor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @fornecedores = Fornecedor.all
    respond_with(@fornecedores)
  end

  def show
    respond_with(@fornecedor)
  end

  def new
    @fornecedor = Fornecedor.new
    respond_with(@fornecedor)
  end

  def edit
  end

  def create
    @fornecedor = Fornecedor.new(fornecedor_params)
    if @fornecedor.save
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: @fornecedor.nome)
      redirect_to new_fornecedor_path
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Fornecedor")
      render :new
    end
    respond_with(@fornecedor)
  end

  def update
    @fornecedor.update(fornecedor_params)
    respond_with(@fornecedor)
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
      params.require(:fornecedor).permit(:status, :nome, :cpf, :cnpj, :email, :telefone, :celular, :endereco, :complemento, :bairro, :estado_id, :cidade_id, :documento)
    end
end
