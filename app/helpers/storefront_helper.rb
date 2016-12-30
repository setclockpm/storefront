module StorefrontHelper
  
  def display_logo_on_shadowized_background
    content_tag :div, class: 'intro' do
      image_tag("logo_white_l.png", title: "design-with-confidence", class: "brand").concat(content_tag :div, '', class: 'hero-shadow')
    end
  end
  
  def hero_image_promotion_content(hero_image)
    return if hero_image.caption.blank?
    content_tag(:span, hero_image_caption_content(hero_image), class: 'hero-image-caption-text').concat(tag :br)
  end
  
  def jumbotron_link_to_view_collection(hero_image)
    return unless hero_image.include_link_to_collection?
    link_to("view collection".upcase, main_app.collection_path, class: "btn btn-lg btn-outline hero-image-caption-text")
  end
  
  def link_to_catalog_download(text="Download Catalog")
    link_to text.upcase, "https://s3-ap-southeast-1.amazonaws.com/porthos/public/media/Catalog-2016.pdf", class: "btn btn-lg btn-outline"
  end
  
  def link_to_view_catalog(text="Browse Catalog Online")
    link_to text.upcase, '#', class: "btn btn-lg btn-outline", disabled: true
  end
  
  def toggle_mv_menu_button_tag(html_options={})
    options = { type: 'button', class: 'toggle-mv-menu' }
    options.merge!(html_options) if !html_options.blank?
    button_tag(options) do
      content_tag(:span, 'Toggle navigation', class: 'sr-only').concat(three_icon_bars)
    end
  end
  

  private
    def icon_bar
      content_tag(:span, '', class: 'icon-bar')
    end
    
    def three_icon_bars
      icon_bar.concat(icon_bar.concat(icon_bar))
    end
    
end
