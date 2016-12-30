module Spree
  module Admin
    module HeroImagesHelper
      
      def link_to_new_hero_image
        return unless can? :create, Spree::Image
        button_link_to(Spree.t(:new_hero_image), spree.new_admin_hero_image_url, { class: "btn-success", icon: 'add', id: 'new_image_link' })
      end
      
      def hero_image_caption_content(hero_image)
        hero_image.caption_url.present? ? link_to_hero_image_caption(hero_image) : hero_image.caption
      end
      
      def link_to_hero_image_caption(hero_image)
        link_to caption_link_content(hero_image), hero_image.caption_url, class: 'hero-image-caption-url'
      end
      
      
      private
        def caption_link_content(hero_img)
          hero_img.caption.present? ? hero_img.caption : hero_img.caption_url
        end
      
    end
  end
end