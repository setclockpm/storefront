require 'rails_helper'

RSpec.describe "browsing Products", type: :feature do
  before :each do
    FactoryGirl.create(:product, available_on: 1.year.ago, name: "Pikachu Side Table", slug: "pikachu-side-table")
  end

  it "shows a Product" do
    visit "/products/pikachu-side-table"
    expect(page).to have_content "Pikachu Side Table"
    expect(page).to have_content "Add To Cart"
  end
end