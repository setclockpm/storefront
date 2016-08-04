module StorefrontHelper
  
  def toggle_mv_menu_button_tag(html_options={})
    options = { type: 'button', class: 'toggle-mv-menu' }
    options.merge!(html_options) if !html_options.blank?
    button_tag(options) do
      content_tag(:span, 'Toggle navigation', class: 'sr-only').concat(
        three_icon_bars
      )
    end
  end
  
  
  def featured_in_images
    [nil, "houzz.png", "bhg.png", "redbook.png", "hgtv.png", "nbc.png", "wayfair.png", "overstock.png"]
  end
  
  def featured_item_offset_class(pos)
    offset_cls = 'col-lg-2 col-md-3 col-sm-4 col-xs-6 grid-item'
    offset_cls += ' col-lg-offset-2' if pos % 4 == 0
    offset_cls += ' col-sm-offset-2 col-md-offset-0' if pos % 2 == 0
    offset_cls
  end
  
  def link_to_catalog(text="Download Catalog")
    link_to fa_icon("download", text: text), main_app.download_catalog_url, class: "btn btn-lg btn-outline"
  end
  
  def social_media_icons
    { facebook: 'facebook.com/porthoshome', pinterest: 'pinterest.com', twitter: 'twitter.com', instagram: "instagram.com" }
    ['facebook', 'pinterest', 'twitter', 'instagram']
  end
  
  def send_icon
     fa_icon("paper-plane-o", text: "Submit").html_safe
  end
  
  def toggle_mv_menu_button_tag(html_options={})
    options = { type: 'button', class: 'toggle-mv-menu' }
    options.merge!(html_options) if !html_options.blank?
    button_tag(options) do
      content_tag(:span, 'Toggle navigation', class: 'sr-only').concat(
        three_icon_bars
      )
    end
  end
  

  private
    def three_icon_bars
      icon_bar.concat(icon_bar.concat(icon_bar))
    end
    
    def icon_bar
      content_tag(:span, '', class: 'icon-bar')
    end
  
end
