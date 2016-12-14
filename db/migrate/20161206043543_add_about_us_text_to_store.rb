class AddAboutUsTextToStore < ActiveRecord::Migration
  def change
    add_column :spree_stores, :about_us_slogan, :string
    add_column :spree_stores, :about_us_text, :text
  end
end
