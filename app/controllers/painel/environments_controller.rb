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
end
