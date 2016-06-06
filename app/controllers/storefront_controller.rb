class StorefrontController < ApplicationController
  CATALOG      = "Porthos_Home_New_Items.pdf"
  CATALOG_LINK = "#{Rails.root}/public/#{CATALOG}"
  
  
  
  def index
    logger.debug "\n\n\nIP Address: #{request.remote_ip}\n\n\n"
  end
  
  def catalog
    head(:bad_request) and return unless File.exist?(CATALOG_LINK)
    send_file CATALOG_LINK, filename: CATALOG, type: "application/pdf"
  end
  
  def temp
    render layout: false
  end
  
end
