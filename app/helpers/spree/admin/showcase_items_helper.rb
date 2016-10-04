module Spree
  module Admin
    module ShowcaseItemsHelper
      def link_to_new_showcase_item
        return unless can? :create, Spree::Image
        button_link_to(Spree.t(:new_collection_image), spree.new_admin_showcase_image_url, { class: "btn-success", icon: 'add', id: 'new_image_link' })
      end
    end
  end
end