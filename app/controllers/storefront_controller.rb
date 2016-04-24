class StorefrontController < ApplicationController
  CATALOG      = "Porthos_Home_New_Items.pdf"
  CATALOG_LINK = "#{Rails.root}/public/#{CATALOG}"
  
  
  
  def hello
    
  end
  
  def catalog
    head(:bad_request) and return unless File.exist?(CATALOG_LINK)
    send_file CATALOG_LINK, filename: CATALOG, type: "application/pdf"
  end
  
end
