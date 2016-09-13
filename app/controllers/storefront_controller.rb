class StorefrontController < ApplicationController
  helper 'spree/products'
  layout 'porthos'
  respond_to :html
  
  CATALOG      = "Porthos_Home_New_Items.pdf"
  CATALOG_LINK = "#{Rails.root}/public/#{CATALOG}"
  
  
  
  def collection
    
  end
  
  def index
   @message = Message.new
   render layout: "application"
  end
  
  def catalog
    head(:bad_request) and return unless File.exist?(CATALOG_LINK)
    send_file CATALOG_LINK, filename: CATALOG, type: "application/pdf"
  end
  
  def about
    
  end
  
end
