class Spree::Admin::WebsitePhotosController < ApplicationController

  def index
    raise params.inspect
    @hero_images = HeroImage.all
  end

end
