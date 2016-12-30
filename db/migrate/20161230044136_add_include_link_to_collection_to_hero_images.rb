class AddIncludeLinkToCollectionToHeroImages < ActiveRecord::Migration
  def change
    add_column :hero_images, :include_link_to_collection, :boolean
    change_column :hero_images, :caption, :string, limit: 25
  end
end