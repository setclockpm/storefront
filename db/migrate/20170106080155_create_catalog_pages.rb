class CreateCatalogPages < ActiveRecord::Migration
  def change
    create_table :catalog_pages do |t|
      t.attachment :image
      t.integer :position
    end
  end
end
