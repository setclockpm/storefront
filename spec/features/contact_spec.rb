require 'rails_helper'

feature 'Contact us page interactions' do
  
  background do
  end
  
  scenario "loads successfully." do
    visit main_app.contact_path
    expect(find('form#contact-form')).to have_select('message[subject]')
    expect(find('select#subject').all('option').size).to eq(3)
  end
  
  
  feature "Selecting Wholesale option" do
    background do
    end
    
    scenario "sumbits successfully." do
      visit main_app.contact_path(subject: 'Wholesale')
      expect(SeoResult.count).to eq(2)
    end
  end
  
  feature "selecting 'Other' option", js: true do
    background do
    end
    
    scenario "sumbits successfully." do 
      visit main_app.contact_path
      click_link "Add SEO Record"
      select('http://igotzdatseo.center', from: 'message[subject]')
      
    end
  end
end