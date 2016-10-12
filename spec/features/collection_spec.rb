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
    product           = create(:product, name: 'Chihuahua Chair', sku: 'A100', description: 'lorem ipsum', available_on: '2013-08-14 01:02:03', slug: 'taco-bell-esse')
    showcased_product = create(:product, name: 'Gorilla Glue Stool', sku: 'GG123B', description: 'lorem ipsum', available_on: '2013-08-14 01:02:03', slug: 'gorilla-glue-stool')
    image             = File.open(File.expand_path('../../features/assets/burger-chi.jpg', __FILE__))
    showcased_image   = File.open(File.expand_path('../../features/assets/rainbow.png', __FILE__))
    product.images.create!(attachment: image)
    showcased_product.images.create!(attachment: showcased_image)
  end
  
  scenario "load correctly and without errors", js: true do
    visit main_app.collection_path
    expect(page.has_selector?('a.collection-img-link')).to be true
  end
  
  scenario "load correctly and without errors", js: true do
    visit main_app.root_path
    expect(page).to have_selector('a.collection-img-link', count: 1)
  end
  
  
end
