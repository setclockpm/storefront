class Spree::Admin::HeroImagesController < Spree::Admin::BaseController
  before_filter :find_hero_image, only: [:show, :edit, :update, :destroy]
  include Spree::Backend::Callbacks

  def index
    @hero_images = HeroImage.all
  end

  def show
    
  end

  def new
    @hero_image = HeroImage.new
  end

  def edit
  end

  def create
    params[:hero_image][:position] = HeroImage.next_available_position
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
      flash[:notice] = 'HeroImage was successfully updated.'
      redirect_to(@hero_image)
    else
      render :edit
    end
  end

  def destroy
    @hero_image.destroy
    redirect_to(admin_website_photos_url)
  end

  private
    def hero_image_params
      params.require(:hero_image).permit(:attachment, :caption, :caption_url, :alt, :position)
    end
    
    def find_hero_image
      @hero_image = HeroImage.find(params[:id])
    end

end
