class AddPorthosSkuToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :porthos_sku, :string, limit: 15
  end
end
