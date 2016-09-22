module PreviewsHelper
  
  def collection_preview_items
    ["preview1.png", "preview2.png", "preview3.png"]
  end
  
  def preview_thumbnail(item)
    # if item.default_image?
#       image_tag(item.default_image, alt: item.name)
#     else
#       image_tag("missing_preview.png", alt: "No image for this creation")
#     end
  end
  
  def preview_reference(image, index)
    
    # padded_revision = 'r%04d' % creation.revision
  #   link = link_to(creation_thumbnail(creation),
  #                  creation,
  #                  title: "More info on #{creation.name}")
  #   size = number_to_human_size(creation.filesize)
  #   raw("#{link} (#{size}, #{creation.stage},
  #       #{padded_revision}, #{creation.format.upcase})")
  end
  
end
