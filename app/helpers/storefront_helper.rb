module StorefrontHelper
  
  def toggle_mv_menu_button_tag(html_options={})
    options = { type: 'button', class: 'toggle-mv-menu' }
    options.merge!(html_options) if !html_options.blank?
    button_tag(options) do
      content_tag(:span, 'Toggle navigation', class: 'sr-only').concat(three_icon_bars)
    end
  end
  
  def link_to_catalog(text="Download Catalog")
    link_to text.upcase, main_app.download_catalog_url, class: "btn btn-lg btn-outline"
  end
  
  def send_icon
    fa_icon("paper-plane-o", text: "Submit").html_safe
  end
  

  private
    def three_icon_bars
      icon_bar.concat(icon_bar.concat(icon_bar))
    end
    
    def icon_bar
      content_tag(:span, '', class: 'icon-bar')
    end
  
end
