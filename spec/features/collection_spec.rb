require 'rails_helper'

# #################################################################
#  
#  
# 
# ----------------------------------------------------------------
feature 'Collection Pages' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
    end
  end
  
  scenario "load correctly and without errors", js: true do
    visit main_app.collection_path
    expect(page.has_selector?('a.collection-img-link')).to be true
  end
  
  
end
