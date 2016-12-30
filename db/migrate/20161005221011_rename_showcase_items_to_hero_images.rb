class RenameShowcaseItemsToHeroImages < ActiveRecord::Migration
  def change
    rename_table  :showcase_items, :hero_images
    add_column    :hero_images, :caption, :string
    add_column    :hero_images, :caption_url, :string
    remove_column :hero_images, :front_page
  end
end