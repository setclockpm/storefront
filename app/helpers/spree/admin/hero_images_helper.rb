module Spree
  module Admin
    module HeroImagesHelper
      def link_to_new_hero_image
        return unless can? :create, Spree::Image
        button_link_to(Spree.t(:new_hero_image), spree.new_admin_hero_image_url, { class: "btn-success", icon: 'add', id: 'new_image_link' })
      end
    end
  end
end