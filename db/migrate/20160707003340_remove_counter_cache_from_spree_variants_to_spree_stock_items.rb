class RemoveCounterCacheFromSpreeVariantsToSpreeStockItems < ActiveRecord::Migration
  def up
    if column_exists?(:spree_variants, :stock_items_count)
      remove_column :spree_variants, :stock_items_count
    end
    
    if column_exists?(:spree_variants, :porthos_sku)
      remove_column :spree_variants, :porthos_sku
    end
  end

  def down
  end
end
