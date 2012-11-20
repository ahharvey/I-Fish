class DesasController < ApplicationController
  # GET /desas
  # GET /desas.json
  def index
    @desas = Desa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @desas }
    end
  end

  # GET /desas/1
  # GET /desas/1.json
  def show
    @desa = Desa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @desa }
    end
  end

  # GET /desas/new
  # GET /desas/new.json
  def new
    @desa = Desa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @desa }
    end
  end

  # GET /desas/1/edit
  def edit
    @desa = Desa.find(params[:id])
  end

  # POST /desas
  # POST /desas.json
  def create
    @desa = Desa.new(params[:desa])

    respond_to do |format|
      if @desa.save
        format.html { redirect_to @desa, notice: 'Desa was successfully created.' }
        format.json { render json: @desa, status: :created, location: @desa }
      else
        format.html { render action: "new" }
        format.json { render json: @desa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /desas/1
  # PUT /desas/1.json
  def update
    @desa = Desa.find(params[:id])

    respond_to do |format|
      if @desa.update_attributes(params[:desa])
        format.html { redirect_to @desa, notice: 'Desa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @desa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desas/1
  # DELETE /desas/1.json
  def destroy
    @desa = Desa.find(params[:id])
    @desa.destroy

    respond_to do |format|
      format.html { redirect_to desas_url }
      format.json { head :no_content }
    end
  end
end
