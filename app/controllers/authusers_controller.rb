class AuthusersController < ApplicationController
  before_action :set_authuser, only: [:show, :edit, :update, :destroy]

  # GET /authusers
  # GET /authusers.json
  def index
    @authusers = Authuser.all
  end

  # GET /authusers/1
  # GET /authusers/1.json
  def show
  end

  # GET /authusers/new
  def new
    @authuser = Authuser.new
  end

  # GET /authusers/1/edit
  def edit
  end

  # POST /authusers
  # POST /authusers.json
  def create
    @authuser = Authuser.new(authuser_params)

    respond_to do |format|
      if @authuser.save
        format.html { redirect_to @authuser, notice: 'Authuser was successfully created.' }
        format.json { render :show, status: :created, location: @authuser }
      else
        format.html { render :new }
        format.json { render json: @authuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authusers/1
  # PATCH/PUT /authusers/1.json
  def update
    respond_to do |format|
      if @authuser.update(authuser_params)
        format.html { redirect_to @authuser, notice: 'Authuser was successfully updated.' }
        format.json { render :show, status: :ok, location: @authuser }
      else
        format.html { render :edit }
        format.json { render json: @authuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authusers/1
  # DELETE /authusers/1.json
  def destroy
    @authuser.destroy
    respond_to do |format|
      format.html { redirect_to authusers_url, notice: 'Authuser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authuser
      @authuser = Authuser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authuser_params
      params[:authuser]
    end
end
