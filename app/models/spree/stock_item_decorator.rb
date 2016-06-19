Spree::StockItem.class_eval do
  
  def update_count(qty)
    self.update_column(:count_on_hand, qty)
  end
  
  
  
  private
  
end