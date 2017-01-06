class CatalogPagesController < ApplicationController
  before_action :set_catalog_page, only: [:show, :edit, :update, :destroy]

  # GET /catalog_pages
  # GET /catalog_pages.json
  def index
    @catalog_pages = CatalogPage.all
  end

  # GET /catalog_pages/1
  # GET /catalog_pages/1.json
  def show
  end

  # GET /catalog_pages/new
  def new
    @catalog_page = CatalogPage.new
  end

  # GET /catalog_pages/1/edit
  def edit
  end

  # POST /catalog_pages
  # POST /catalog_pages.json
  def create
    @catalog_page = CatalogPage.new(catalog_page_params)

    respond_to do |format|
      if @catalog_page.save
        format.html { redirect_to @catalog_page, notice: 'Catalog page was successfully created.' }
        format.json { render :show, status: :created, location: @catalog_page }
      else
        format.html { render :new }
        format.json { render json: @catalog_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalog_pages/1
  # PATCH/PUT /catalog_pages/1.json
  def update
    respond_to do |format|
      if @catalog_page.update(catalog_page_params)
        format.html { redirect_to @catalog_page, notice: 'Catalog page was successfully updated.' }
        format.json { render :show, status: :ok, location: @catalog_page }
      else
        format.html { render :edit }
        format.json { render json: @catalog_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalog_pages/1
  # DELETE /catalog_pages/1.json
  def destroy
    @catalog_page.destroy
    respond_to do |format|
      format.html { redirect_to catalog_pages_url, notice: 'Catalog page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalog_page
      @catalog_page = CatalogPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalog_page_params
      params.require(:catalog_page).permit(:image, :position)
    end
end
