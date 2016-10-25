class AddRetailUrlFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :retail_vendor_url, :string
    add_column :spree_products, :retail_vendor, :string, limit: 24
    add_column :spree_products, :showcased, :boolean, default: false
  end
end
