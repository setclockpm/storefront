module ApplicationHelper

  
  # def meta_data
#     object = instance_variable_get('@'+controller_name.singularize)
#     meta = {}
#
#     if object.kind_of? ActiveRecord::Base
#       meta[:keywords] = object.meta_keywords if object[:meta_keywords].present?
#       meta[:description] = object.meta_description if object[:meta_description].present?
#     end
#
#     if meta[:description].blank? && object.kind_of?(Spree::Product)
#       meta[:description] = truncate(strip_tags(object.description), length: 160, separator: ' ')
#     end
#
#     meta.reverse_merge!({
#       keywords: current_store.meta_keywords,
#       description: current_store.meta_description,
#     }) if meta[:keywords].blank? or meta[:description].blank?
#     meta
#   end
#
#   def meta_data_tags
#     meta_data.map do |name, content|
#       tag('meta', name: name, content: content)
#     end.join("\n")
#   end
#
  def current_store
    Spree::Store.first
  end
  
  def title(page_title="Porthos Home - Shop Boldy For Your Style")
    content_for(:title) { page_title }
  end
end
