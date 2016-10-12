module CollectionHelper
  
  def collection_items
    Spree::Variant.where(is_master: true).joins(:images).all
   #["0.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", "11.jpg"]
  end
  
  def collection_reference(image, options={})
    path = "#{options[:preview] ? 'preview' : 'portfolio'}/#{image}"
    content_tag :figure do
      link_to collection_thumbnail(path), "assets/#{path}", class: 'collection-img-link'
    end
  end
  
  def collection_image_reference(variant, options={})
    content_tag :figure do
      link_to collection_image_thumbnail_tag(variant), variant.collection_image.attachment.url(:original), class: 'collection-img-link'
    end
    
  end
  
  
  private
    def collection_image_thumbnail_tag(variant)
      image_tag variant.collection_image.attachment.url(:product), alt: "#{variant.name}", class: "collection-image"
    end
  
end
