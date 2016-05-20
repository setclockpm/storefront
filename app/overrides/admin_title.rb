
Deface::Override.new(name:             'override-admin-product-breadcrumb',
                     virtual_path:     'spree/admin/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to @product.name, edit_admin_product_url(@product)',
                     original: "")

Deface::Override.new(name:             'override-admin-title',
                     virtual_path:     'spree/admin/shared/_head',
                     replace_contents: 'title', text: 'Porthos Portal - <%= controller.controller_name.titleize %>',
                     original:         'b94dd9df96e085d9a869128fa811ee3aaf55fab1')


Deface::Override.new(name:             'override-storefront-title',
                     virtual_path:     'spree/shared/_head',
                     replace_contents: 'title', 
                     text:             'Porthos Home: <%= title = (controller.controller_name.titleize == "Home" ? 
                                                                  "Shop Boldly For Your Style" : 
                                                                   controller.controller_name.titleize) %>',
                     original:         '6c51b34d058f87d10add34374293afce2bf817e2')
