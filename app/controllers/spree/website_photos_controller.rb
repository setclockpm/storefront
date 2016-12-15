class Spree::Admin::WebsitePhotosController < ApplicationController

  def index
    @hero_images = HeroImage.all
    
  end

end
