module ProductsHelper
  
  def active_select_thumbnail_background(variant, i)
    content_tag :div, 
                 variant_primary_thumbnail_url(variant),
                 id: "variant-#{variant.id}", class: "active-select-color-surface variant-description #{default_thumbnail_bg(variant)}",
                 data: { color: color_options(variant).downcase, thumb: variant.primary_thumbnail_url }
    
  end
  
  
  # Displays swatch background iff no images exist for variant
  def default_thumbnail_bg(v)
    color_options(v).downcase unless v.images.any?
  end
  
  def variant_primary_thumbnail_url(v)
    image_tag(v.primary_thumbnail_url, class: "thumbnail") if v.primary_thumbnail_url
  end
  
end



