require 'rails_helper'

describe "Hero Images", type: :feature, js: true do
  stub_authorization!

  let(:file_path) { Rails.root + "spec/support/palom-porom.jpg" }

  before do
    # Ensure attachment style keys are symbolized before running all tests
    # Otherwise this would result in this error:
    # undefined method `processors' for \"48x48>\
    HeroImage.attachment_definitions[:attachment][:styles].symbolize_keys!
  end

  context "uploading, editing, and deleting a hero image" do
    it "should allow an admin to upload and edit an image for a product" do
      HeroImage.attachment_definitions[:attachment].delete :storage

      visit spree.admin_website_photos_path
      click_link "new_hero_image_link"
      attach_file('hero_image_attachment', file_path)
      page.check 'Active'
      click_button "Create"
      expect(page).to have_content("successfully created!")

      click_icon(:edit)
      fill_in "hero_image_alt", with: "palom & porom"
      fill_in "hero_image_caption", with: "Twin Power"
      fill_in "hero_image_caption_url", with: 'https://www.reddit.com/r/FinalFantasy/'
      page.check 'Active' #hero_image_active
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page).to have_content("palom & porom")
      expect(page).to have_content("Twin Power")
      accept_alert do
        click_icon :delete
      end
      expect(page).not_to have_content("palom & porom")
    end
    
    it "should display <caption_url> iff it is filled out and <caption> is not. Otherwise caption should be displayed" do
      HeroImage.attachment_definitions[:attachment].delete :storage
      hero_image = HeroImage.create(attachment: File.open(file_path), caption_url: 'https://www.reddit.com/r/FinalFantasy/', active: true, position: (HeroImage.all_active.size + 1))
      visit spree.admin_website_photos_path
      
      # Ensure hero image(s) display
      expect(page).not_to have_content("No Hero Images Found.")

      within("table.table") do
        expect(page).to have_content(hero_image.caption_url)
        # Ensure no duplicate images are displayed
        expect(page).to have_css("tbody tr", count: 1)
        expect(page).to have_content("https://www.reddit.com/r/FinalFantasy/")
      end
      
      click_icon(:edit)
      fill_in "hero_image_caption", with: "Final Fantasy IV"
      click_button "Update"

      # Ensure caption is now displayed
      within("tbody") do
        expect(page.body).to have_content("Final Fantasy IV")
      end
      
    end
  end


end
