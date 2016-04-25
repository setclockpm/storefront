module Spree
  module BaseHelper
    
    def logo(image_path=Spree::Config[:logo])
      link_to image_tag(image_path), root_path
    end
    
  end
end
