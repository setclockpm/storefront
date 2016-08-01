module StorefrontHelper
  
  
  def link_to_catalog(text="Download Catalog")
    link_to fa_icon("download", text: text), main_app.download_catalog_url, class: "btn btn-lg btn-outline"
  end
  
  def social_media_icons
    ['facebook', 'google-plus', 'twitter', 'linkedin']
  end
  
  def send_icon
     fa_icon("paper-plane-o", text: "Submit").html_safe
  end
  
  
  private
  
  
end
