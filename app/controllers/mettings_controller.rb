class MettingsController < ApplicationController
  before_action :set_metting, only: [:show, :edit, :update, :destroy]

  # GET /mettings
  # GET /mettings.json
  def index
    @mettings = Metting.all
  end

  # GET /mettings/1
  # GET /mettings/1.json
  def show
    @users = @metting.users
  end

  # GET /mettings/new
  def new
    @metting = Metting.new
  end

  # GET /mettings/1/edit
  def edit
    redirect_to mettings_url
  end

  # POST /mettings
  # POST /mettings.json
  def create
    import = MettingImport.new(metting_params)
    @metting = import.metting

    respond_to do |format|
      if import.save
        format.html { redirect_to @metting, notice: 'Metting was successfully created.' }
        format.json { render :show, status: :created, location: @metting }
      else
        format.html { render :new }
        format.json { render json: @metting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mettings/1
  # PATCH/PUT /mettings/1.json
  def update
    redirect_to mettings_url
    respond_to do |format|
      if @metting.update(metting_params)
        format.html { redirect_to @metting, notice: 'Metting was successfully updated.' }
        format.json { render :show, status: :ok, location: @metting }
      else
        format.html { render :edit }
        format.json { render json: @metting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mettings/1
  # DELETE /mettings/1.json
  def destroy
    @metting.destroy
    respond_to do |format|
      format.html { redirect_to mettings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metting
      @metting = Metting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metting_params
      if params[:metting].present?
        params.require(:metting).permit(:name, :gtm_file)
      else
        {}
      end
    end
end
