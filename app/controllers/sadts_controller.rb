class SadtsController < ApplicationController
  before_action :set_sadt, only: [:show, :edit, :update, :destroy]

  # GET /sadts
  # GET /sadts.json
  def index
    @sadts = Sadt.all
  end

  # GET /sadts/1
  # GET /sadts/1.json
  def show
  end

  # GET /sadts/new
  def new
    @sadt = Sadt.new
  end

  # GET /sadts/1/edit
  def edit
  end

  # POST /sadts
  # POST /sadts.json
  def create
    @sadt = Sadt.new(sadt_params)

    respond_to do |format|
      if @sadt.save
        format.html { redirect_to @sadt, notice: 'Sadt was successfully created.' }
        format.json { render :show, status: :created, location: @sadt }
      else
        format.html { render :new }
        format.json { render json: @sadt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sadts/1
  # PATCH/PUT /sadts/1.json
  def update
    respond_to do |format|
      if @sadt.update(sadt_params)
        format.html { redirect_to @sadt, notice: 'Sadt was successfully updated.' }
        format.json { render :show, status: :ok, location: @sadt }
      else
        format.html { render :edit }
        format.json { render json: @sadt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sadts/1
  # DELETE /sadts/1.json
  def destroy
    @sadt.destroy
    respond_to do |format|
      format.html { redirect_to sadts_url, notice: 'Sadt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sadt
      @sadt = Sadt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sadt_params
      params.fetch(:sadt, {})
    end
end
