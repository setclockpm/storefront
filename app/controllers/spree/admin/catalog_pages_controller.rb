class Spree::Admin::CatalogPagesController < Spree::Admin::BaseController
  before_action :set_catalog_page, only: [:show, :edit, :update, :destroy]
  include Spree::Backend::Callbacks



  def show
  end

  def new
    @catalog_page = CatalogPage.new
  end

  def edit
  end
  
  
  def create
    @catalog_page = CatalogPage.new(catalog_page_params)
    
    if @catalog_page.save
      invoke_callbacks(:create, :after)
      flash[:success] = flash_message_for(@catalog_page, :successfully_created)
      respond_with(@catalog_page) do |format|
        format.html { redirect_to admin_catalog_url }
        format.js   { render layout: false }
      end
    else
      respond_with(@catalog_page) do |format|
        format.html { render action: :new }
        format.js { render layout: false }
      end
    end
  end

  def update
    if @catalog_page.update_attributes(catalog_page_params)
      flash[:notice] = 'Hero Image was successfully updated!'
      redirect_to admin_catalog_url
    else
      render :edit
    end
  end
  
  def update_positions
    ActiveRecord::Base.transaction do
      params[:positions].each do |id, index|
        CatalogPage.find(id).set_list_position(index)
      end
    end

    respond_to do |format|
      format.js { render text: 'Ok' }
    end
  end

  def destroy
    if @catalog_page.destroy
      flash[:success] = Spree.t('notice_messages.catalog_page_deleted')
    else
      flash[:error] = Spree.t('notice_messages.catalog_page_not_deleted')
    end
    
    respond_with(@catalog_page) do |format|
      format.html { redirect_to admin_catalog_url }
      format.js { render_js_for_destroy }
    end
  end
  
  

  protected
    # This is required for the update_positions action to work properly.
    # Acts as list possibly?
    def model_class
      CatalogPage
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
