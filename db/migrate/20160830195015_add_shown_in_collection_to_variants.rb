class AddShownInCollectionToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :shown_in_collection, :boolean, default: false
  end
end
