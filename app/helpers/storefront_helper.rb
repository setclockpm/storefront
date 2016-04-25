module StorefrontHelper  
  
  
  def link_to_catalog(text="Download Catalog")
    link_to fa_icon("download", text: text), main_app.download_catalog_url, class: "btn btn-lg btn-outline"
  end
  
  def logo(image_path='logo.png')
    link_to image_tag(image_path), root_path
  end
  
  def social_media_icons
    ['facebook', 'google-plus', 'twitter', 'linkedin', 'dribbble']
  end
  
  
  private
  
  
end
