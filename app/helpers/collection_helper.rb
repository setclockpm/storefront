module CollectionHelper
  
  def collection_items
   ["0.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", "11.jpg"]
  end
  
  def collection_reference(image)
    content_tag :figure do
      collection_thumbnail(image)
    end
  end
  
  
  private
  
    def collection_thumbnail(img)
      image_tag "portfolio/#{img}", title: "furniture collection", class: "collection-image"
    end
  
  
end
