class MaterialsController < ApplicationController
  before_action :set_material, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]



  def search
    @query = params[:query]

    if @query.present?
      if ActiveRecord::Base.connection.adapter_name.downcase.start_with?('sqlite')
        # Use LOWER() for case-insensitive search in SQLite
        @materials = Material.where(
          "LOWER(name) LIKE LOWER(?) OR LOWER(location) LIKE LOWER(?) OR LOWER(instructor) LIKE LOWER(?)",
          "%#{@query}%", "%#{@query}%", "%#{@query}%"
        )
      else
        # Use ILIKE for PostgreSQL
        @materials = Material.where(
          "name ILIKE ? OR location ILIKE ? OR instructor ILIKE ?", 
          "%#{@query}%", "%#{@query}%", "%#{@query}%"
        )
      end
    else
      @materials = Material.none
    end

    render :results
  end

  # GET /materials or /materials.json
  def index
    @materials = Material.all
  end

  # GET /materials/1 or /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    # @material = Material.new
    @material = current_user.materials.build
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials or /materials.json
  def create
    # @material = Material.new(material_params)
    @material = current_user.materials.build(material_params)
    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: "Material was successfully created." }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1 or /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: "Material was successfully updated." }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1 or /materials/1.json
  def destroy
    @material.destroy!

    respond_to do |format|
      format.html { redirect_to materials_path, status: :see_other, notice: "Material was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @material = current_user.materials.find_by(id: params[:id])
    redirect_to materials_path, notice: "Not Authorized To Edit This Material" if @material.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def material_params
      params.expect(material: [ :name, :location, :quantity, :instructor, :check_in, :check_out, :user_id ])
    end
end
