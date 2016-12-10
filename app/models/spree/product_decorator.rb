
Spree::Product.class_eval do
  ALLOWED_SHOWCASE_ITEMS = 3 unless const_defined?(:ALLOWED_SHOWCASE_ITEMS)

  validate :showcased_items_count, on: :create
  validate :other_showcased_items_count, on: :update
  
  # Class methods
  def self.showcased_items
    where('showcased')
  end
  
  
  # Instance methods
  def lifestyle_shot?
    master_images.any?
  end
  
  def collection_image
    master_images.first if master_images.any?
  end
  
  
  
  private
    def other_showcased_items_count
      unless showcased_items_count_valid?(id)
        errors.add(:base, "Only up to #{ALLOWED_SHOWCASE_ITEMS} showcased products are allowed.", count: ALLOWED_SHOWCASE_ITEMS)
      end
    end
    
    def showcased_items_count
      unless showcased_items_count_valid?
        errors.add(:base, "Only up to #{ALLOWED_SHOWCASE_ITEMS} showcased products are allowed.", count: ALLOWED_SHOWCASE_ITEMS)
      end
    end
    
    def showcased_items_count_valid?(reject_id=-1)
      showcased_items = self.class.showcased_items.reject{|si| si.id == reject_id }
      puts "Showcased items: #{showcased_items.map{|s| [s.id, s.name] }} \n\n\n #{showcased_items.size}\n\n\n"
      showcased_items.size <= ALLOWED_SHOWCASE_ITEMS
    end
  
end
