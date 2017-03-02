class Painel::EnvironmentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  # GET /environments
  def index
    @environments = Gclinic::Environment.all
  end

  # GET /environments/1
  def show
    @empresa = Empresa.find_by(nome: @environment.name)
  end

  # GET /environments/new
  def new
    @environment = Gclinic::Environment.new
    @environment.users.build
  end

  # GET /environments/1/edit
  def edit
    @environment.users.build
  end

  # POST /environments
  def create
    @environment = Gclinic::Environment.new(environment_params)
    Thread.current[:environment_type]= @environment.database_name
    if @environment.save
      @empresa = Empresa.new(nome: @environment.name, environment_name: @environment.database_name, slug: @environment.name.downcase.gsub(" ", "-"), environment: @environment)
      @empresa.save
      @admin = @environment.users.first
      @admin.empresa= @empresa
      @admin.admin= true
      @admin.save
      redirect_to painel_environment_path(@environment), notice: 'Environment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /environments/1
  def update
    if @environment.update(environment_params)
      redirect_to @environment, notice: 'Environment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /environments/1
  def destroy
    @environment.destroy
    redirect_to environments_url, notice: 'Environment was successfully destroyed.'
  end

  def remove_model
    @environment = Gclinic::Environment.find(params[:id])
    @environment_users = @environment.users
    @environment_model = @environment.environment_models.find_by(model_id: params[:environment_model_id])
    # binding.pry
    @environment.users.each do |user|
      @model = user.user_models.find_by(model_id: @environment_model.model.id)
      @model.destroy if !@model.nil?
    end
    @environment_model.destroy
    redirect_to :back
  end

  def edit_environment_admin_account
    @environment = Gclinic::Environment.find(params[:id])
    Thread.current[:environment_type]= @environment.database_name
    @empresa = Empresa.find_by(nome: @environment.name)
    @environment_admin_account = @environment.users.find(params[:admin_id])
  end

  def update_environment_admin_account
    @environment = Gclinic::Environment.find(user_params[:environment_id])
    @environment_admin_account = @environment.users.find(user_params[:id])
    if user_params[:password]==""
      if @environment_admin_account.update_without_password(user_params)
        flash[:info] = "Usuário atualizado."
        redirect_to painel_environment_path(@environment)
      else
        render :edit_environment_admin_account
      end
    elsif user_params[:password] != ""
      if @environment_admin_account.update(user_params)
        flash[:info] = "Usuário atualizado."
        redirect_to painel_environment_path(@environment)
      else
        render :edit_environment_admin_account
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Gclinic::Environment.friendly.find(params[:id])
      Thread.current[:environment_type]= @environment.database_name
      session[:environment_type]= @environment.database_name
    end

    # Only allow a trusted parameter "white list" through.
    def environment_params
      params.require(:gclinic_environment).permit(:name, :database_name, :slug,
                                                  users_attributes: [:name,
                                                                     :email,
                                                                     :password,
                                                                     :password_confirmation,
                                                                     :admin,
                                                                     :_destroy])
    end

    def user_params
      params.require(:gclinic_user).permit(:id, :name,  :email, :password, :password_confirmation, :admin, :empresa_id, :environment_id)
    end
end