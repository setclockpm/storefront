require 'rails_helper'

# #################################################################
#  
#  
# 
# ----------------------------------------------------------------
feature 'Collection Items' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
    end
    product           = create(:product, name: 'Chihuahua Chair', sku: 'CH1U4H', description: 'lorem ipsum', available_on: '2013-08-14 01:02:03', slug: 'taco-bell-esse')
    image             = File.open(File.expand_path('../../features/assets/burger-chi.jpg', __FILE__))
    product.images.create!(attachment: image)
  end
  
  scenario "load correctly and without errors" do
    visit main_app.collection_path
    expect(page).to have_selector('a.collection-img-link', count: 1)
  end
  
  scenario "on front page load correctly and without errors" do
    showcased_product = create(:product, name: 'Gorilla Glue Stool', sku: 'GG123B', description: 'lorem ipsum', available_on: 2.months.ago, slug: 'gg-stool', showcased: true)
    showcased_image   = File.open(File.expand_path('../../features/assets/rainbow.png', __FILE__))
    showcased_product.images.create!(attachment: showcased_image)
    
    visit "#{main_app.root_path}/#fpjs-collection"
    expect(page).to have_selector('div.main-row')
    expect(page).to have_selector('a.collection-img-link', count: 4)
  end
  
  
end
