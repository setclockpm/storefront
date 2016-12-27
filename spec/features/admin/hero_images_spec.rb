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
      click_button "Create"
      expect(page).to have_content("successfully created!")

      click_icon(:edit)
      fill_in "image_alt", with: "palom & porom"
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page).to have_content("palom & porom")

      accept_alert do
        click_icon :delete
      end
      expect(page).not_to have_content("palom & porom")
    end
  end

  # Regression test for #2228
  # it "should see variant images", js: false do
#     hero_image.create!(attachment: File.open(file_path))
#     visit admin_website_photos_path
#
#     expect(page).not_to have_content("No Hero Images Found.")
#     within("table.table") do
#       expect(page).to have_content(variant.options_text)
#
#       #ensure no duplicate images are displayed
#       expect(page).to have_css("tbody tr", count: 1)
#
#       #ensure variant header is displayed
#       within("thead") do
#         expect(page.body).to have_content("Variant")
#       end
#
#       #ensure variant header is displayed
#       within("tbody") do
#         expect(page).to have_content("Size: S")
#       end
#     end
#   end

end
