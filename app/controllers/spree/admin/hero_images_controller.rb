class Spree::Admin::HeroImagesController < Spree::Admin::BaseController
  before_filter :find_hero_image, only: [:show, :edit, :update, :destroy]
  include Spree::Backend::Callbacks

  def index
    @hero_images = HeroImage.order(:position)
  end

  def show
    
  end

  def new
    @hero_image = HeroImage.new
  end

  def edit
  end

  def create
    @hero_image = HeroImage.new(hero_image_params)
    
    if @hero_image.save
      invoke_callbacks(:create, :after)
      flash[:success] = flash_message_for(@hero_image, :successfully_created)
      respond_with(@hero_image) do |format|
        format.html { redirect_to admin_website_photos_path }
        format.js   { render layout: false }
      end
    else
      respond_with(@hero_image) do |format|
        format.html { render action: :new }
        format.js { render layout: false }
      end
    end
  end

  def update
    if @hero_image.update_attributes(hero_image_params)
      flash[:notice] = 'Hero Image was successfully updated!'
      redirect_to admin_website_photos_path
    else
      render :edit
    end
  end
  
  def update_positions
    ActiveRecord::Base.transaction do
      params[:positions].each do |id, index|
        HeroImage.find(id).set_list_position(index)
      end
    end

    respond_to do |format|
      format.js { render text: 'Ok' }
    end
  end

  def destroy
    if @hero_image.destroy
      flash[:success] = Spree.t('notice_messages.hero_image_deleted')
    else
      flash[:error] = Spree.t('notice_messages.hero_image_not_deleted')
    end
    
    respond_with(@hero_image) do |format|
      format.html { redirect_to admin_website_photos_url }
      format.js { render_js_for_destroy }
    end
  end
  
  

  protected
    # This is required for the update_positions action to work properly.
    # Acts as list possibly?
    def model_class
      HeroImage
    end


    private
      def hero_image_params
        params.require(:hero_image).permit(:alt, :active, :attachment, :caption, :caption_url, :include_link_to_collection, :position)
      end
      
      def find_hero_image
        @hero_image = HeroImage.find(params[:id])
      end

end
