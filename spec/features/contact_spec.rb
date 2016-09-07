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
  
  scenario "Loads successfully with subject parameter being passed in query string." do
    subject = 'Wholesale Inquiries'
    visit main_app.contact_path(subject: subject)
    expect(find('form select', visible: false).value).to eq(subject)
  end
  
  feature "Form submission with valid data" do
    background do
      @field_entries = {}
    end
    
    scenario "valid long form with valid info should submit successfully.", js: true do
      @field_entries[:subject] = "Product Availability"
    
      visit main_app.contact_path
      expect(page.has_selector?('form select', visible: false)).to be true
      save_and_open_page
      fill_inquiry_form_text_fields(@field_entries)
      click_button 'send'
    end
    
  end
  
  
  
 
  feature "Selecting Wholesale option" do

    
  end
  #
  # feature "selecting 'Other' option", js: true do
  #   background do
  #   end
  #
  #   scenario "sumbits successfully." do
  #     visit main_app.contact_path
  #     click_link "Send"
  #     select('http://igotzdatseo.center', from: 'message[subject]')
  #
  #   end
  # end
end