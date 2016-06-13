namespace :s3 do
  require "aws-sdk"
  require 'fileutils'
  require 'open-uri'
  namespace :import do
    
    desc "Import inventory images to Amazon S3 via addition through Paperclip"
    task :images => :environment do
      SIZE_OPTIONS  = Spree::OptionType.find_by(name: 'size').option_values.map(&:name)
      COLOR_OPTIONS = Spree::OptionType.find_by(name: 'color').option_values.map(&:name)
      
      credentials   = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      s3            = Aws::S3::Resource.new(credentials: credentials, region: 'ap-southeast-1')
      # Directory for inventory pictures ready to be bulk imported.
      # Cna be a local dir to an s3 bucket.
      @bucket       = s3.bucket('porthos')
      
      
      # enumerate every object in a bucket
      all_object_keys = bucket.objects.map(&:key)
     
      
      puts "\n\n\n================================== Today's date: #{Date.today} =================================="
      puts "Preparing to possible create image variants for #{file_count} files."
      puts "==================================_________________________________==================================\n\n\n"
      #### Main loop ###################################################################################################
      # What we require is:
      # 1) The local image path (@path_to_raw_image)
      # 2) Master SKU (@master_sku_bucket)
      # 3) Original SKU - This to look up and attach the viewable object to the image being created.
      # 4) File Name (on S3)
      # ----------------------------------------------------------------------------------------------------------------
      Rails.env == 'production' ? pull_images_from_holding_s3_bucket : pull_images_from_local_directory
    end
    
    
    
    desc "Import inventory images DIRECTLY to Amazon S3. THIS BYPASSES Paperclip meaning a DB record is not created!"
    task :direct => :environment do
      if @s3_file_name.blank?
        puts "[#{@composite}] | Encountered file with no suffix (#{@master_sku_bucket}) - Skipping"
#       elsif @s3_file_name[0] =~ /\d/
#         puts "[#{@composite}] | #{@master_sku_bucket}/#{@s3_file_name} Only 1 photo exists for this SKU (Only 1 color option most likely)"
#         puts "Uploading file"
#         File.open(@path_to_raw_image, 'rb') do |file|
#           s3.bucket(bucket.name).object("public/inventory/#{@master_sku_bucket}/#{@s3_file_name}").put(body:file)
#         end
#         puts "Uploaded #{@s3_file_name} to #{bucket.name}/public/inventory/#{@master_sku_bucket}/"
#       elsif SIZE_OPTIONS.include?(@s3_file_name[0])
#         puts "[#{@composite}] | #{@master_sku_bucket}/#{@s3_file_name} Normal file format with size option"
#         puts "Uploading file"
#         File.open(@path_to_raw_image, 'rb') do |file|
#           s3.bucket(bucket.name).object("public/inventory/#{@master_sku_bucket}/#{@s3_file_name}").put(body:file)
#         end
#         puts "Uploaded #{@s3_file_name} to #{bucket.name}/public/inventory/#{@master_sku_bucket}/"
#       else
#         puts "[#{@composite}] | #{@master_sku_bucket}/#{@s3_file_name} Normal file format"
#         puts "Uploading file"
#         File.open(@path_to_raw_image, 'rb') do |file|
#           s3.bucket(bucket.name).object("public/inventory/#{@master_sku_bucket}/#{@s3_file_name}").put(body:file)
#         end
#         puts "Uploaded #{@s3_file_name} to #{bucket.name}/public/inventory/#{@master_sku_bucket}/"
      end
    end
    
  end
  
  
  private
  
    def pull_images_from_local_directory
      @previous_sku = nil
      
      Dir.foreach(RAW_ASSET_DIRECTORY) do |item|
        next if item == '.' or item == '..' or item == '.DS_Store'
    
        @composite          = item.split("\s").compact
        @path_to_raw_image  = "#{RAW_ASSET_DIRECTORY}/#{item}"
        @master_sku_bucket  = @composite[0]
        @original_sku       = item.split('-').first.strip
        @s3_file_name       = compose_s3_file_name
        
        do_import
      end
    end
    
    def pull_images_from_holding_s3_bucket
      @previous_sku = nil
      
      #objex = @bucket.objects.select{|o| o.key =~ /public\/assets/ }
      # bucket.objects.map(&:key)
      @bucket.objects(prefix: 'public/assets/').each do |obj|
        # We don't neet the direcrtory it's in, that's why skipping the first returned object
        next if obj.key == '.' or obj.key == '..' or obj.key == 'public/assets/'
        
        @composite          = obj.key.split("\s").compact
        @path_to_raw_image  = obj.public_url
        @master_sku_bucket  = @composite[0]
        @original_sku       = obj.key.split('-').first.strip
        @s3_file_name       = compose_s3_file_name
        
        puts "About to pull image at location: #{@path_to_raw_image}"
        do_import
      end
      
    end
  
    def do_import
      puts "\n --- Original SKU: #{@original_sku} --- "
      puts "image path: #{@path_to_raw_image} | @composite: #{@composite} | #{@master_sku_bucket}/#{@s3_file_name}"
      
      # TODO: Improve readability maybe?
      # All that's being done here is retrieving Variant record by master sku if we were unable to do so via original_sku.
      # There are only certain conditions we want to do this and they're abstracted out to the model's <find_by_master_sku> method.
      # This is why it appears we're wasting space by potentially calling the same method twice here. 
      
     
      # TODO: Implement import for many images per 1 SKU
      # ------------------------------------------------------------------------------------------------------------------------
      @variant = Spree::Variant.find_by(sku: @original_sku) || Spree::Variant.find_by_master_sku(@master_sku_bucket, @original_sku)
            
      puts "Skipping because previous_sku (#{previous_sku}) == @original_sku (#{@original_sku})" if @previous_sku == @original_sku
      return if @previous_sku == @original_sku
      
      
      if @variant
        puts "Skipping because in image already exists for this variant" if @variant.images.any?
        return if @variant.images.any?
        
        @image        = @variant.images.build(attachment: open(@path_to_raw_image){|f| f.read }, alt: image_alt)
        @previous_sku = @original_sku if @image.save!
      else
        puts "\n\nWARNING: No variant found w/ SKU: <#{@original_sku}> (or its master SKU)! 
               Please re-check parse or verify if file name is following convention"
      end
    end
    
    def file_count
      return @bucket.objects.size if Rails.env == 'production'
      Dir[File.join(RAW_ASSET_DIRECTORY, '**', '*')].count{|f| File.file?(f) }
    end
    
    def image_alt
      return @variant.name if @variant.is_master?
      "#{@variant.name} in #{@variant.option_values.first.presentation}" rescue "#{@variant.name} with color option"
    end
    
    
    # For 2nd spot of composite composite[1], possible values can be { <COLOR>, 'ALL', '-', <SIZE> }
    def compose_s3_file_name
      # Encountered a file name without an ordinal, SKU, or any Option Type e.g. color
      # No subdirectory created or needed here.
      return if @composite.size == 1
      # ----------------------------------------------
      
      # Encountered a file name with only an ordinal. Most likely a SKU with no variants except the master one
      # e.g 'TH0093 - 1.jpg'
      return @composite.last if @composite[1] == '-'
      # ---------------------------------------------
      
      # Encountered a file name with a <SIZE> option type value in it. 
      # e.g. 'CH002R L NAT - 1.jpg' | Returns in format: L-NAT-1.jpg
      return "#{@composite[1]}-#{@composite.last(@composite.size-2).join('-')}".squeeze('-') if SIZE_OPTIONS.include?(@composite[1])
      # ---------------------------------------------
      
      # Encountered a file name with just a <COLOR> or option type value in it. Most typical case.
      # Also can be a single word such as ALL or LIFESTYLE
      # e.g. 'CH003E RED - 1.jpg' | Returns in format: RED-1.jpg
      @composite.last(@composite.size-1).join
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
#rsync -a -e "ssh -p 40000" /var/www/cerp/production/shared/backups/*.bak deploy@50.116.5.75:/var/www/cerp/shared/backups
#PATH=/usr/bin/pg_dump:$PATH sudo -u postgres pg_dump -t accounts -Fc cerp_production > accounts.out
#PATH=/usr/bin/pg_dump:$PATH sudo -u postgres pg_dump -Fc cerp_production > backup.out
