module PreviewsHelper
  
  def collection_preview_items
   ["preview0.jpg", "preview1.jpg", "preview2.jpg"]
  end
  
  def preview_reference(image)
    content_tag :figure do
      preview_thumbnail(image)
    end
  end
  
  
  private
  
    def preview_thumbnail(img)
      image_tag "preview/#{img}", title: "furniture collection preview", class: "collection-preview-image"
    end
  
end
