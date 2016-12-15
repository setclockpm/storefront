class HeroImage < ActiveRecord::Base
  
  has_attached_file :attachment,
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :large,
                    path:            ':rails_root/public/system/:class/:position/:style/:filename',
                    styles:          { small: '240x160>', preview: '480x360>', product: '1024x768>', large: '2048x1536>', lightbox: '800x600>' },
                    url:             '/public/assets/images/hero/:position/:style/:filename'
                    
   validates_attachment :attachment, presence: true, content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }
  
  
  
   def self.all_active
     where('active')
   end
  
  private
    def storefront_gallery_within_capacity
      HeroImage.all_active.size <= 6
    end
  
end
