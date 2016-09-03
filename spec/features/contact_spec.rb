require 'rails_helper'

feature 'Contact us page interactions' do
  
  background do
    unless Spree::Store.exists?
      FactoryGirl.create(:store)
    end
  end
  
  scenario "loads successfully." do
    visit main_app.contact_path
    expect(find('form#new_message')).to have_select('message[subject]')
    expect(find('select#message_subject').all('option').size).to eq(4)
  end
  
 
  feature "Selecting Wholesale option" do

    scenario "sumbits successfully." do
      visit main_app.contact_path(subject: 'Wholesale')
      # expect(Messages.count).to eq(2)
    end
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