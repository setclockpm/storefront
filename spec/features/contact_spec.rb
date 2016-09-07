require 'rails_helper'

# #################################################################
#  Use field_entries hash to use custom values for these fields
#  e.g. field_entries[:subject] = "Product Availability"
#
#  Example of checking dropdown existance with options:
#  expect(find('form.release-to-work')).to have_select('candidates', with_options: [seo_rep.full_name, second_seo_rep.full_name])
# ----------------------------------------------------------------
feature 'Contact us page interactions' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
    end
  end
  
  scenario "Loads successfully without subject parameter being passed." do
    visit main_app.contact_path
    expect(find('form#new_message')).to have_select('message[subject]')
    expect(find('select#subject').all('option').size).to eq(5)
  end
  
  scenario "Loads successfully with subject parameter being passed in query string.", js: true do
    visit main_app.root_path
    expect(page.has_selector?('div#contact-card')).to be true
    expect(find('div#contact-card')).to have_link('Wholesale')
    
    find('ul.contact-links').click_link('Wholesale')
    save_and_open_page
    
    expect(find('form select', visible: false).value).to eq('Wholesale Inquiries')
  end
  
  
  
  feature "Form submission with valid data" do
    background do
      @field_entries = {}
    end
    
    scenario "valid long form with valid info should submit successfully.", js: true do
      @field_entries[:subject] = "Product Availability"
    
      visit main_app.contact_path
      expect(page.has_selector?('form select', visible: false)).to be true
      fill_inquiries_form_with_valid_data(@field_entries)
      click_button 'send'
    end
    
  end
  
  feature "Form submission with invalid or missing data" do

    
  end
 
end