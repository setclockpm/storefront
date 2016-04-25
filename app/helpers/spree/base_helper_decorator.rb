
Spree::BaseHelper.module_eval do
  
  def logo(image_path=Spree::Config[:logo])
    link_to image_tag(image_path), main_app.root_path
  end
  
end