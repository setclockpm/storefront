require 'rails_helper'

# #################################################################
#  
#  
# 
# ----------------------------------------------------------------
feature '"Browsing Collection - ' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
      FactoryGirl.create(:product, available_on: 1.year.ago, name: "Pikachu Side Table", slug: "pikachu-side-table")
      
    end
  end
  
  
  
  
end
