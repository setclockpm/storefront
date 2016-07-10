Deface::Override.new(name:             'add-thumbnails-for-all-variants',
                     virtual_path:     'spree/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to "#{@product.name} (#{@product.sku})", product_url(@product), target: "_blank"',
                     original: "")

#
# Deface::Override.new(name:             'expose-color-option-radio-buttons',
#                      virtual_path:     'spree/products/_cart_form',
#                      replace_contents: 'div#product-variants',
#                      partial:          'products/expose_variant',
#                      original:         'b39ce20b7c92da45a8f3a6e51f509dbe22ffa5eb')
#
#
# Deface::Override.new(name:             'qty-field-to-select',
#                      virtual_path:     'spree/products/_cart_form',
#                      replace_contents: "erb[loud]:contains('number_field_tag')",
#                      text:              "number_field_tag :quantity, 1, class: 'title form-control', min: 1, max: @product.total_on_hand",
#                      original:         nil)
#
#
# Deface::Override.new(name:             'add-xs-to-product-variants',
#                      virtual_path:     'spree/products/_cart_form',
#                      set_attributes:   'div#product-variants',
#                      attributes:       { class: 'col-md-6 col-sm-9 col-xs-12' },
#                      original:         nil)
#
#
# Deface::Override.new(name:             'add-xs-to-product-price',
#                      virtual_path:     'spree/products/_cart_form',
#                      set_attributes:   'div[data-hook="product_price"]',
#                      attributes:       { class: 'col-md-5 col-sm-9 col-xs-12' },
#                      original:         nil)


Deface::Override.new(name:             'add-xs-to-product-right-part',
                     virtual_path:     'spree/products/show',
                     set_attributes:   'div[data-hook="product_right_part"]',
                     attributes:       { class: 'col-md-8 col-sm-7 col-xs-12' },
                     original:         nil)

#######################################################################################
### The next few overrides handle re-arranging product attributes in cart-form ########
# Deface::Override.new(name:             'grab-product-desc',
#                      virtual_path:     'spree/products/show',
#                      remove:           'div[data-hook="description"]',
#                      original:         nil)

Deface::Override.new(name:             'place-product-desc',
                     virtual_path:     'spree/products/show',
                     insert_after:     'div[data-hook="cart_form"]',
                     cut:              'div[data-hook="description"]',
                     original:         nil, disabled: false)
                     
                     
                     
                     
