Deface::Override.new(name:             'add-thumbnails-for-all-variants',
                     virtual_path:     'spree/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to "#{@product.name} (#{@product.sku})", product_url(@product), target: "_blank"',
                     original: "")


Deface::Override.new(name:             'expose-color-option-radio-buttons',
                     virtual_path:     'spree/products/_cart_form',
                     replace_contents: 'div#product-variants',
                     partial:          'products/expose_variant',
                     original:         'b39ce20b7c92da45a8f3a6e51f509dbe22ffa5eb')