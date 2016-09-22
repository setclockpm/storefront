module PreviewsHelper
  
  def collection_preview_items
   { "preview0.jpg" => { "on Wayfair" => 'http://www.wayfair.com/Porthos-Home-B40284.html' }, 
     "preview1.jpg" => { "in our gallery" => collection_path }, 
     "preview2.jpg" => { "on Overstock" => 'http://www.overstock.com/Porthos-Home,/brand,/results.html' }
   }
  end
  
  def preview_reference(image, dest)
    content_tag :figure do
      preview_thumbnail(image).concat(preview_caption(dest))
    end
  end
  
  
  private
    def preview_caption(dest)
      content_tag :figcaption, (content_tag :h3, "View collection #{dest}")
    end
  
    def preview_thumbnail(img)
      image_tag "preview/#{img}", title: "furniture collection preview", class: "collection-preview-image"
    end
  
end
