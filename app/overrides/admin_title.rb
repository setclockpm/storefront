Deface::Override.new(name:             'override-admin-product-breadcrumb',
                     virtual_path:     'spree/admin/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to "#{@product.name} (#{@product.sku})", product_url(@product), target: "_blank"',
                     original: "")

Deface::Override.new(name:             'override-admin-title',
                     virtual_path:     'spree/admin/shared/_head',
                     replace_contents: 'title', text: 'Porthos Portal - <%= controller.controller_name.titleize %>',
                     original:         'b94dd9df96e085d9a869128fa811ee3aaf55fab1')





Deface::Override.new(name:             'add-import-tab',
                     virtual_path:     'spree/admin/shared/sub_menu/_product',
                     insert_bottom:     "[data-hook='admin_product_sub_tabs']", 
                     text:             '  <%= tab :data_import %>',
                     original:         nil)
