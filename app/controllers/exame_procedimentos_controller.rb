class ExameProcedimentosController < Support::InsideController
  load_and_authorize_resource

  def index
    # @exame_procedimentos = ExameProcedimento.all
    @search = ExameProcedimento.where(empresa_id: current_user.empresa_id).ransack(params[:q])
    @exame_procedimentos = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
  end

  def new
    # @exame_procedimento = ExameProcedimento.new
    @exame_procedimento = current_user.empresa.exame_procedimentos.build
  end

  def edit
  end

  def create
    # @exame_procedimento = ExameProcedimento.new(resource_params)
    @exame_procedimento = current_user.empresa.exame_procedimentos.build(resource_params)
    if @exame_procedimento.save
      redirect_to new_empresa_exame_procedimento_path(current_user.empresa)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Exame Procedimento")
    else
      render :new
    end
  end

  def update
    if @exame_procedimento.update(resource_params)
      redirect_to empresa_exame_procedimentos_path(current_user.empresa)
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Exame Procedimento")
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Exame Procedimento")
      render :edit
    end
  end

  def destroy
    if @exame_procedimento.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Exame Procedimento")
      redirect_to empresa_exame_procedimentos_path(current_user.empresa)
    else
      flash[:alert] = t("flash.actions.#{__method__}.alert", resource_name: "Exame Procedimento")
    end
  end

  private
    def resource_params
      params.require(:exame_procedimento).permit(:descricao, :tabela, :codigo_procedimento, :empresa_id)
    end
end
