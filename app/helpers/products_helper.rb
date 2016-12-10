module ProductsHelper
  
  def active_select_thumbnail_background(variant, i)
    content_tag :div, 
                 variant_primary_thumbnail_url(variant),
                 id: "variant-#{variant.id}", class: "active-select-color-surface variant-description #{default_thumbnail_bg(variant)}",
                 data: { color: color_options(variant).downcase, thumb: variant.primary_thumbnail_url }
    
  end
  
  def admin_showcased_products_label
    dat_label = "#{Spree.t(:showcase)}?"
    return dat_label if Spree::Product.showcased_items.size < Spree::Product::ALLOWED_SHOWCASE_ITEMS
    "#{dat_label} (At Max)"
  end
  
  # Displays swatch background iff no images exist for variant
  def default_thumbnail_bg(v)
    color_options(v).downcase unless v.images.any?
  end
  
  def lifestyle_background_image(product)
    product.lifestyle_shot? ? image_tag(variant.images.first.attachment.url(:product)) : "musketeer.png"
  end
  
  def next_page_button(on_last_pg, is_remote, url)
    on_last_pg ? page_decoy("next") : next_page_link(is_remote, url)
  end
  def prev_page_button(on_first_pg, is_remote, url)
    on_first_pg ? page_decoy("previous") : prev_page_link(is_remote, url)
  end
  
  
  def specifications
    # Remove properties that are ambiguous 'Features' (to be used in another section)
    @features           = @product_properties.select{|pp| pp.property.name =~ /features/i }
    @product_properties = @product_properties - @features
    # Remove properties with blank values
    @product_properties.reject{|s| s.value.blank? }
  end
  
  def variant_primary_thumbnail_url(v)
    if v.primary_thumbnail_url
      image_tag(v.primary_thumbnail_url, class: "thumbnail") 
    else
      image_tag 'no-image.png', class: "no-thumbnail thumbnail", size: '56x56'
    end
  end
  
  
  private

    def page_decoy(direction)
      text = raw(send(:t, "views.pagination.#{direction}"))
      content_tag :span, text, class: 'pg-button page-step disabled'
    end
    
    def next_page_link(remote, url)
      link_to raw(t 'views.pagination.next'), url, rel: 'next', remote: remote, class: "pg-button page-step"
    end
    def prev_page_link(remote, url)
      link_to raw(t 'views.pagination.previous'), url, rel: 'prev', remote: remote, class: "pg-button page-step"
    end
  
end



