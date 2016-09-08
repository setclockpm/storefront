require 'rails_helper'

# #################################################################
#  Use field_entries hash to use custom values for these fields
#  e.g. field_entries[:subject] = "Product Availability"
#
#  Example of checking dropdown existance with options:
#  expect(find('form.release-to-work')).to have_select('candidates', with_options: [seo_rep.full_name, second_seo_rep.full_name])
# ----------------------------------------------------------------
feature 'Contact us page interactions: ' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
    end
  end
  
  
  feature "Initial page load / reload: " do
    # Only 2 ways possible: With an argument in query string intended for subject and the normal way.
    # The only argument that is accepted as an argument is the subject.
    scenario "Successful w/o subject in query string." do
      visit main_app.contact_path
      expect(find('form#new_message')).to have_select('message[subject]')
      expect(find('select#subject').all('option').size).to eq(5)
    end
  
    scenario "Successful with subject parameter passed in query string.", js: true do
      visit main_app.root_path
      expect(page.has_selector?('div#contact-card')).to be true
      expect(find('div#contact-card')).to have_link('Wholesale')
      find('ul.contact-links').click_link('Wholesale')
      expect(find('form select', visible: false).value).to eq('Wholesale Inquiries')
    end
  end
  
  feature "Form submission" do
    background do
      @field_entries = {}
    end
    
    feature "with valid data." do
      background do
        @field_entries[:subject] = "Product Availability"
      end
      
      scenario "Long form should submit successfully.", js: true do
        visit main_app.contact_path
        expect(page.has_selector?('form select', visible: false)).to be true
        fill_inquiries_form_with_valid_data(@field_entries)
        click_button 'send'
      end
      
      scenario "Short form should submit successfully.", js: true do
        visit main_app.root_path
        expect(page.has_selector?('form select', visible: false)).to be false
        find('input[type=email]').click
        fill_inquiries_form_with_valid_data
        click_button 'send'
      end
    end
    
    feature "with invalid or missing data" do
      background do
        @field_entries[:content] = 'I intentionally left some fields blank! SMH.'
        @field_entries[:name]    = 'Forgetful Frank'
        @field_entries[:phone]   = '213-555-1212'
      end
      
      scenario "Long form submision should be prevented.", js: true do
        visit main_app.contact_path
        fill_text_fields(@field_entries)
        click_button 'send'
        expect(page).to have_content("Please enter an email address.")
        expect(page).to have_content("You haven't chosen the reason for your inquiry.")
      end
      
      scenario "Short form submision should be prevented.", js: true do
        @field_entries[:email] = 'forgetfulfrank@example.com'
        @field_entries[:name]  = nil
        
        visit main_app.root_path
        fill_text_fields(@field_entries)
        click_button 'send'
        expect(page).to have_content("Please enter a name.")
      end
    end
    
  end
  
end