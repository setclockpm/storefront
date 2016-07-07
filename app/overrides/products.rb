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
                     
                     
Deface::Override.new(name:             'qty-field-to-select',
                     virtual_path:     'spree/products/_cart_form',
                     replace_contents: "erb[loud]:contains('number_field_tag')",
                     text:              "number_field_tag :quantity, 1, class: 'title form-control', min: 1, max: @product.total_on_hand",
                     original:         nil)

              
              
# Deface::Override.new(name:             'show-sku',
#                      virtual_path:     'spree/products/_cart_form',
#                      insert_before:    'div.add-to-cart',
#                      text:             '<%= @product.sku %>',
#                      original:         'eb3fa668cd98b6a1c75c36420ef1b238a1fc55ad', disabled: false)    
