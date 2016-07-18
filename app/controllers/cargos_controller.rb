class CargosController < ApplicationController
  load_and_authorize_resource param_method: :resource_params

  def index
    @cargos = Cargo.da_empresa_atual(empresa_atual["id"])
    respond_with(@cargos)
  end

  def show
    respond_with(@cargo)
  end

  def new
    @cargo = current_usuario.empresa.cargos.build
    respond_with(@cargo)
  end

  def edit
  end

  def create
    @cargo = current_usuario.empresa.cargos.build(resource_params)
    if @cargo.salvar
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to new_cargo_path
    else
      render :new
    end
  end

  def update
    @cargo.update(resource_params)

    if @cargo.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to cargos_path
    else
      render :edit
    end
  end

  def destroy
    if @cargo.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to cargos_url
    else
      flash[:alert] = t("flash.actions.#{__method__}.alert", resource_name: @cargo.class)
    end
  end

  private
    def resource_params
      params.require(:cargo).permit(:nome, :status, :empresa_id)
    end
end
