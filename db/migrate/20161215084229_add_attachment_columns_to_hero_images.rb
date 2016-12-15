class AddAttachmentColumnsToHeroImages < ActiveRecord::Migration
  def change
    add_attachment :hero_images, :attachment
    add_column :hero_images, :alt, :text
    add_column :hero_images, :position, :integer
    add_column :hero_images, :active, :boolean
  end
end
