module CollectionHelper
  
  def collection_items
    Spree::Variant.where(is_master: true).joins(:images).all
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
  
  def collection_thumbnail(img_path)
    image_tag img_path, title: "furniture collection pull-sku-from-record", class: "collection-image"
  end
  
  
  private
    def collection_image_thumbnail_tag(variant)
      image_tag variant.collection_image.attachment.url(:product), alt: "#{variant.name}", class: "collection-image"
    end
  
end
