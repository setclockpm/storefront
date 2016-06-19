namespace :seller_cloud do
  require "aws-sdk"
  require 'fileutils'
  require 'open-uri'
  require 'inventory_management/connections/seller_cloud'
  
  namespace :inventory do
    
    desc "Synchronize quantity of inventory from SellerCloud API to porthos"
    task :sync => :environment do
      
      @master_sku_hash = master_sku_hash
      @sc_connection   = InventoryManagement::Connections::SellerCloud.connection
      @skus_to_research = []
      
      @master_sku_hash.each do |sku, variant|
        puts "========================= ON SKU #{sku} | #{variant.sku} ======================"
        qty = @sc_connection.get_available_qty(sku)
        
        if qty >= 0
          variant.update_stock_count(qty)
        else
          puts "-        Warning: Quantity received < 0, adding variant (#{variant.sku}) to set of variants needed to researched        -"
          @skus_to_research << variant
        end
        
      end
    end
  end
  
  
  private
    def master_sku_hash
      hash = {}
      Spree::Variant.find_each do |v|
        hash[v.sku]=v
      end
      hash
    end

end



namespace :images do
  
  desc "Convert images to 500x500 and jpg using MiniMagick gem"
  task :convert => :environment do
    Dir.foreach(RAW_ASSET_DIRECTORY) do |item|
      next if item == '.' or item == '..' or item == '.DS_Store'
      #convert images to 500x500 so loading time isnt hella slow
      @path_to_raw_image = "#{RAW_ASSET_DIRECTORY}/#{item}"
      image = MiniMagick::Image.new(@path_to_raw_image) #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
      puts "On image: #{image.path}"
      image.format "jpg"
      puts "Changed to jpg"
      image.resize "500x500!"
      puts "resized to 500x500"
    end
  end
  
end
