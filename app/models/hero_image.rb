class HeroImage < ActiveRecord::Base
  MAX_HERO_IMAGES_ALLOWED = 5 unless const_defined?(:MAX_HERO_IMAGES_ALLOWED)
  
  has_attached_file :attachment,
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    default_style:   :product,
                    styles:          { small: '240x160>', product: '1024x768>', large: '2048x1536>', thumb: '120x80>' },
                    path:            ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
                    url:             "/system/:class/:attachment/:id/:style/:basename.:extension"
                    
  validate :max_allowed_hero_images_not_exceeded
  validates :position, presence: true
  validates_attachment :attachment, presence: true, content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }
  
  
  
  class << self
    def all_active
      where('active')
    end

    def max_allowed
      MAX_HERO_IMAGES_ALLOWED
    end

    def next_available_position
      return 1 unless all_active.any?
      all_active.select(:position).max + 1
    end
  end




  def find_dimensions
    temporary = attachment.queued_for_write[:original]
    filename  = temporary.path unless temporary.nil?
    filename  = attachment.path if filename.blank?
    geometry  = Paperclip::Geometry.from_file(filename)
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
    def max_allowed_hero_images_not_exceeded
      current_hero_images = self.class.all_active
      
      # Validation passes if less than the max allowed. (Obviously)
      return if current_hero_images.size < MAX_HERO_IMAGES_ALLOWED
      
      # ##############################################################################################
      # Now we check if dealing with one of the hero_image records that's included
      # within the current active ones. In other words, if it's one of the <MAX_HERO_IMAGES_ALLOWED>.
      return if current_showcased_items.map(&:id).include?(id)
      # If it was, then this passed validation since we were either:
      #   Updating another attribuite for this record (current_hero_images qty doesn't change)
      #   Updating this attribuite (since we can only deactivate, current_hero_images qty decreases)
      #   Destroying this record (current_hero_images qty decreases)
      # ##############################################################################################
      
      # ##############################################################################################
      # Now we're definitely dealing with a hero image that's NOT within the set of <MAX_HERO_IMAGES_ALLOWED> 
      # records that put us at the limit.
      # We don't count if this record is one of the showcased. (Can never increase showcase count)
      return unless attributes['active']
      # We don't ccre unless another record trying to become showcased
      errors.add(:base, :too_many_hero_images, count: MAX_HERO_IMAGES_ALLOWED)
    end
  
end
