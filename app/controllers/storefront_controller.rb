class StorefrontController < ApplicationController
  before_action :load_hero_images, only: [:index]
  helper 'spree/products'
  respond_to :html
  
  CATALOG      = "Catalog-2016.pdf"
  CATALOG_LINK = "#{Rails.root}/public/#{CATALOG}"
  
  
  def index
    @message = Message.new
    render layout: 'storefront'
  end
  
  def catalog
    head(:bad_request) and return unless File.exist?(CATALOG_LINK)
    send_file CATALOG_LINK, filename: CATALOG, type: "application/pdf"
    render layout: 'utility'
  end
  
  def about
    Rails.logger.debug "\n == User Agent: #{request.user_agent} == \n"
    render layout: 'application'
  end
  
  
  private
  
    def load_hero_images
      @hero_images = HeroImage.all_active.order(:position)
    end
  
end
