class Spree::Admin::WebsitePhotosController < Spree::Admin::BaseController

  def index
    @hero_images = HeroImage.order(:position)
  end
  
  def footer
    @footer_image = Footer.first.image
  end
  
  def catalog
    @catalog_pages = CatalogPage.order(:position)
  end

end
