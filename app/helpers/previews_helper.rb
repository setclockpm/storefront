module PreviewsHelper
  
  def collection_preview_items
   ["preview0.jpg", "preview1.jpg", "preview2.jpg"]
  end
  
  def preview_reference(image)
    collection_reference(image, preview: true)
  end
  
  
  private
  
end
