require "aws-sdk"
require 'fileutils'
require 'open-uri'

class ImageGenerator
  SIZE_OPTIONS  = Spree::OptionType.find_by(name: 'size').option_values.map(&:name)
  COLOR_OPTIONS = Spree::OptionType.find_by(name: 'color').option_values.map(&:name)
  
  
  def initialize(path=nil)
    @credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    s3           = Aws::S3::Resource.new(credentials: @credentials, region: 'ap-southeast-1')
    # Directory for inventory pictures ready to be bulk imported.
    # Cna be a local dir to an s3 bucket.
    @bucket       = s3.bucket(ENV['S3_BUCKET_NAME'])
  end
  
  
  def process
    Rails.logger.info "================================== Today's date: #{Date.today} =================================="
    Rails.logger.info "Preparing to possible create image variants for #{file_count} files."
    Rails.logger.info "==================================_________________________________==================================\n\n\n"
    #### Main loop ###################################################################################################
    # What we require is:
    # 1) The local image path (@path_to_raw_image)
    # 2) Master SKU (@master_sku_bucket)
    # 3) Original SKU - This to look up and attach the viewable object to the image being created.
    # 4) File Name (on S3)
    # ----------------------------------------------------------------------------------------------------------------
    #Rails.env == 'production' ? pull_images_from_holding_s3_bucket : pull_images_from_local_directory
    pull_images_from_holding_s3_bucket
    true
  end
  
  
  private
  
    def do_import
      Rails.logger.info "\n--- Original SKU: #{@original_sku} --- "
      Rails.logger.info "--- Image path: #{@path_to_raw_image} | @composite: #{@composite} | #{@master_sku_bucket}/#{@s3_file_name} ---"
      
      # TODO: Improve readability maybe?
      # All that's being done here is retrieving Variant record by master sku if we were unable to do so via original_sku.
      # There are only certain conditions we want to do this and they're abstracted out to the model's <find_by_master_sku> method.
      # This is why it appears we're wasting space by potentially calling the same method twice here. 
      
     
      # TODO: Implement import for many images per 1 SKU
      # ------------------------------------------------------------------------------------------------------------------------
      @variant = Spree::Variant.find_by(sku: @original_sku) || Spree::Variant.find_by_master_sku(@master_sku_bucket, @original_sku)
      
      Rails.logger.info "\n-Variant found: #{@variant.inspect} "
      return skipped_because_previous_sku_matches_this_sku if @previous_sku == @original_sku
      
      
      if @variant
        return skipped_because_image_exists_for_variant if @variant.images.any?
        Rails.logger.info "- About to build image from #{@path_to_raw_image} with alt text of #{image_alt} -"
        @image        = @variant.images.build(attachment: s3_raw_file, alt: image_alt)
        @previous_sku = @original_sku if @image.save!
      else
        puts "\nWARNING: No variant found w/ SKU: <#{@original_sku}> (or its master SKU)! Please re-check parse or verify format of file name"
        Rails.logger.info "\nWARNING: No variant found w/ SKU: <#{@original_sku}> (or its master SKU)! Please re-check parse or verify format of file name"
      end
    end
  
    def pull_images_from_local_directory
      @previous_sku = nil
      
      Dir.foreach(RAW_ASSET_DIRECTORY) do |item|
        # We're in a local *nix file system for 
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
      # puts @bucket.objects.map(&:key)
      @bucket.objects(prefix: 'public/assets/').each do |obj|
        item = obj.key.dup
        # We don't neet the direcrtory it's in, that's why skipping the first returned object
        next if item == '.' or item == '..' or item == 'public/assets/'
        
        item.slice!('public/assets/')
        @composite          = item.split("\s").compact
        @object_key         = obj.key
        @path_to_raw_image  = "#{RAW_ASSET_DIRECTORY}#{obj.key}".gsub("\s", '+')
        @master_sku_bucket  = @composite[0]
        @original_sku       = item.split('-').first.strip
        @s3_file_name       = compose_s3_file_name
        
        Rails.logger.info "About to pull image at location: #{@path_to_raw_image}"
        do_import
      end
      
    end
  
    def skipped_because_previous_sku_matches_this_sku
      Rails.logger.info "Skipping because previous_sku (#{@previous_sku}) == @original_sku (#{@original_sku})"
    end
    
    def skipped_because_image_exists_for_variant
      Rails.logger.info "Skipping because in image already exists for this variant"
    end
    
    def s3_raw_file
      #Rails.env == 'production' ? 
      s3 = Aws::S3::Client.new(credentials: @credentials, region: 'ap-southeast-1')
      response = s3.get_object(bucket:'porthos', key: @object_key)
      resp_body = response.body
      Rails.logger.info "Response body of object just d/l'd and put into memory #{resp_body.inspect}\n\n"
      #=> #<StringIO ...> 
      resp_body
      # For local files ->  File.open(@path_to_raw_image, 'rb')
    end
    
    def file_count
      return @bucket.objects(prefix: 'public/assets/').count# if Rails.env == 'production'
      #Dir[File.join(RAW_ASSET_DIRECTORY, '**', '*')].count{|f| File.file?(f) }
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
