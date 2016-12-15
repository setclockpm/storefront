class Spree::Admin::HeroImagesController < ApplicationController
  before_filter :find_hero_image, only: [:show, :edit, :update, :destroy]

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
    @hero_image = HeroImage.new(params[:hero_image])
  end

  def update
    if @hero_image.update_attributes(params[:hero_image])
      flash[:notice] = 'HeroImage was successfully updated.'
      redirect_to(@hero_image)
    else
      render :edit
    end
  end

  def destroy
    @hero_image.destroy
    redirect_to(hero_images_url)
  end

  private
    def hero_image_params
      params.require(:hero_image).permit(:caption, :caption_url)
    end
    
    def find_hero_image
      @hero_image = HeroImage.find(params[:id])
    end

end
