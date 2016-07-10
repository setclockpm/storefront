
Spree::BaseHelper.module_eval do
  
  def logo(image_path=Spree::Config[:logo])
    link_to image_tag(image_path), main_app.root_path
  end
  
  def link_to_cart(text=nil)
    text = text ? h(text) : Spree.t('cart')
    css_class = nil
    
    puts "\nsimple_current_order.nil?: #{simple_current_order.nil?}"
    puts "simple_current_order.item_count.zero? #{simple_current_order.item_count.zero?}\n"
    
    if simple_current_order.nil? or simple_current_order.item_count.zero?
      text = cart_icon
      css_class = 'empty'
    else
      text = "#{cart_icon} #{cart_item_count_badge}"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "cart-info #{css_class}"
  end
  
  # helper to determine if its appropriate to show the store menu
  def store_menu?
    puts "\n%w{thank_you}.exclude? params[:action]: #{%w{thank_you}.exclude? params[:action]}"
    puts "%w{thank_you} #{%w{thank_you}} | params[:action]: #{params[:action]}\n"
    %w{thank_you}.exclude? params[:action]
  end
  
  
  private
    def cart_icon
      fa_icon "shopping-cart", class: "fa-2x"
    end
    
    def cart_item_count_badge
      content_tag :span, cart_item_count, id: 'item-count-badge', class: 'badge'
    end
    
    def cart_item_count
      content_tag :span, simple_current_order.item_count, id: 'item-count', class: 'number', data: { item_count: simple_current_order.item_count }
    end
  
end