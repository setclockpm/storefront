Deface::Override.new(name:             'override-admin-product-breadcrumb',
                     virtual_path:     'spree/admin/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to "#{@product.name} (#{@product.sku})", edit_admin_product_url(@product), target: "_blank"',
                     # text:             '"#{@product.name} (#{@product.sku})"',
                     original: "")

Deface::Override.new(name:             'override-admin-title',
                     virtual_path:     'spree/admin/shared/_head',
                     replace_contents: 'title', text: 'Porthos Portal - <%= controller.controller_name.titleize %>',
                     original:         'b94dd9df96e085d9a869128fa811ee3aaf55fab1')


Deface::Override.new(name:             'add-import-tab',
                     virtual_path:     'spree/admin/shared/sub_menu/_product',
                     insert_bottom:     "[data-hook='admin_product_sub_tabs']", 
                     text:             '  <%= tab :data_import %>',
                     original:         '5c6807c2920b4280184cbdf867b7ba98e41b576f')
                     

Deface::Override.new(name:             'prefill-alt-img-text',
                     virtual_path:     'spree/admin/images/_form',
                     replace_contents: "erb[loud]:contains('f.text_area')", 
                     text:             "f.text_area :alt, value: @product.name, rows: 4, class: 'form-control'",
                     original:         '034dd1aeb63ffb44b9f28f2c08708ac31f1fda06')
                     
                     
Deface::Override.new(name:             'add-website_photos-tab',
                     virtual_path:     'spree/admin/shared/sub_menu/_promotion',
                     insert_bottom:     "[data-hook='admin_promotion_sub_tabs']",
                     text:             '  <%= tab :website_photos %>',
                     original:         'c894f9343fc5d151fda365e502b1b53b4a4ebc3b')
