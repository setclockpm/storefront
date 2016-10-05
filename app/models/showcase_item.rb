class ShowcaseItem < ActiveRecord::Base
  has_one :image, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  
  validate :storefront_gallery_within_capacity
  
  
  def self.storefront_photos
    where('front_page')
  end
  
  
  private
    def storefront_gallery_within_capacity
      ShowcaseItem.storefront_photos.size <= 6
    end
  
end
