class Spree::Admin::WebsitePhotosController < Spree::Admin::BaseController

  def index
    @hero_images = HeroImage.order(:position)
  end

end
