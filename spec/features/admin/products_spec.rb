# encoding: UTF-8
require 'rails_helper'

feature 'Product Details' do
  stub_authorization!
  given!(:store) { create(:store) }

  background do
    create(:store) unless Spree::Store.exists?
    product = create(:product, name: 'Pikachu Chair', sku: 'A100', description: 'lorem ipsum', available_on: '2013-08-14 01:02:03', slug: 'garden-grove-talk')
    image   = File.open(File.expand_path('../../assets/burger-chi.jpg', __FILE__))
    product.images.create!(attachment: image)
    product.images.create!(attachment: image)
  end


  feature "editing a product's retail vendor" do
    scenario 'should submit successfully', js: true do
      visit spree.admin_products_path
      
      within('table.table tbody tr:nth-child(1)') do
        click_icon(:edit)
      end

      find_field('product_retail_vendor_url').send_keys('https://wayfair.com/porthos-home/ABC123-BLK')
      wait_for_ajax
      sleep 4
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(find_field('product_retail_vendor').value).to eq("Wayfair")
    end
  end
end
