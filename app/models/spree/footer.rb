module Spree
  class Footer < Spree::Base
    has_one :image, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
    
  end
end

# class Spree::Footer < ActiveRecord::Base
# end
