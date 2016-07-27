
Spree::BaseHelper.module_eval do
  
  def logo(image_path=Spree::Config[:logo])
    link_to image_tag(image_path), main_app.root_path, class: 'navbar-logo'
  end
  
  def link_to_cart(text=nil)
    text = text ? h(text) : Spree.t('cart')
    css_class = nil
    
    if simple_current_order.nil? or simple_current_order.item_count.zero?
      text = cart_icon_section
      css_class = 'empty'
    else
      text = "#{cart_icon_section} #{cart_item_count_badge}"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "cart-info #{css_class}"
  end
  
  def taxons_accordion(root_taxon, current_taxon, max_level=1)
    puts "root_taxon: #{root_taxon.name}\ncurrent_taxon: #{current_taxon.name if current_taxon}\nmax_level: #{max_level}"
    return '' if max_level < 1 || root_taxon.leaf?
    taxons = root_taxon.children.map do |taxon|
      content_tag :li, class: 'dl-nav-item' do
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : 'inactive'
        link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_accordion(taxon, current_taxon, max_level - 1)
      end
    end
    safe_join(taxons, "\n")
  end
  
  # helper to determine if its appropriate to show the store menu
  def store_menu?
    puts "\n%w{thank_you}.exclude? params[:action]: #{%w{thank_you}.exclude? params[:action]}"
    puts "%w{thank_you} #{%w{thank_you}} | params[:action]: #{params[:action]}\n"
    %w{thank_you}.exclude? params[:action]
  end
  
  
  private
    def cart_icon_section
      fa_icon "shopping-cart", class: "cart fa-2x"
    end
    
    def cart_item_count_badge
      content_tag :span, cart_item_count, id: 'item-count-badge', class: 'boop-ur-noes quantity-badge'
    end
    
    def cart_item_count
      content_tag :span, simple_current_order.item_count, id: 'item-count', class: 'number', data: { item_count: simple_current_order.item_count }
    end
  
end