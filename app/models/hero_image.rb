class HeroImage < ActiveRecord::Base
  
  has_attached_file :attachment,
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    styles:          { small: '240x160>', product: '1024x768>', large: '2048x1536>', thumb: '120x80>' },
                    path:            ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
                    # path:            ':rails_root/public/system/:class/:basename:position-:style.:extension',
                    url:             "/system/:class/:attachment/:id/:style/:basename.:extension"
                    # url:             '/public/assets/images/hero/:basename:position-:style.:extension'
                    
  validates_attachment :attachment, presence: true, content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }
  validates :position, presence: true
  
  
  [:position].each do |path_facet|
    Paperclip.interpolates path_facet do |attachment, style|
      attachment.instance.send(path_facet)
    end
  end
  
  
  
  class << self
    def all_active
      where('active')
    end
  
    def next_available_position
      return 1 unless all_active.any?
      all_active.select(:position).max + 1
    end
  end




  def find_dimensions
    temporary = attachment.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end
  
  # used by admin products autocomplete
  def mini_url
    attachment.url(:mini, false)
  end
  
  def status
    active? ? 'active' : 'inactive'
  end
  
  
  private
    def storefront_gallery_within_capacity
      HeroImage.all_active.size <= 6
    end
  
end
