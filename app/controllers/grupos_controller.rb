class GruposController < Support::InsideController
  load_and_authorize_resource

  def index
    # @grupos = Grupo.all
    @search = Grupo.where(empresa_id: current_user.empresa_id).ransack(params[:q])
    @grupos = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
  end

  def new
    # @grupo = Grupo.new
    @grupo = current_user.empresa.grupos.build
    @grupo_exame_procedimento = @grupo.grupo_exame_procedimentos.build
  end

  def edit
    @grupo.grupo_exame_procedimentos.build if @grupo.grupo_exame_procedimentos.blank?
  end

  def create
    unless resource_params["grupo_exame_procedimentos_attributes"].first[1]["exame_procedimento_id"].empty?
      @grupo = current_user.empresa.grupos.build(resource_params)
      if @grupo.save
        redirect_to new_empresa_grupo_path(current_user.empresa)
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Grupo")
      else
        render :new
      end
    else
      flash[:error] = "É necessário que haja pelo menos um Exame Procedimento relacionado a este Grupo"
      render :new
    end
  end

  def update
    unless resource_params["grupo_exame_procedimentos_attributes"].first[1]["exame_procedimento_id"].empty?
      if @grupo.update(resource_params)
        redirect_to empresa_grupos_path(current_user.empresa)
        flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Grupo")
      else
        @grupo.grupo_exame_procedimentos.build if @grupo.grupo_exame_procedimentos.blank?
        flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Grupo")
        render :edit
      end
    else
      @grupo.grupo_exame_procedimentos.build if @grupo.grupo_exame_procedimentos.blank?
      flash[:error] = "É necessário que haja pelo menos um Exame Procedimento relacionado a este Grupo"
      render :edit
    end
  end

  def destroy
    if @grupo.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Grupo")
      redirect_to empresa_grupos_path(current_user.empresa)
    else
      flash[:alert] = t("flash.actions.#{__method__}.alert", resource_name: "Grupo")
    end
  end

  private
    def set_grupo
      @grupo = Grupo.find(params[:id])
    end

    def resource_params
      params.require(:grupo).permit(:nome, :empresa_id,
                                    grupo_exame_procedimentos_attributes: [:id, :grupo_id, :exame_procedimento_id, :empresa_id, :_destroy])
    end
end
