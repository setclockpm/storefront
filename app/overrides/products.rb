Deface::Override.new(name:             'add-thumbnails-for-all-variants',
                     virtual_path:     'spree/shared/_product_tabs',
                     replace_contents: "erb[loud]:contains('@product.name')",
                     text:             'link_to "#{@product.name} (#{@product.sku})", product_url(@product), target: "_blank"',
                     original: "")


Deface::Override.new(name:             'expose-color-option-radio-buttons',
                     virtual_path:     'spree/orders/edit',
                     replace_contents: 'div[data-hook="cart_container"]',
                     partial:          'orders/cart',
                     original:         nil)
#
#
# Deface::Override.new(name:             'qty-field-to-select',
#                      virtual_path:     'spree/products/_cart_form',
#                      replace_contents: "erb[loud]:contains('number_field_tag')",
#                      text:              "number_field_tag :quantity, 1, class: 'title form-control', min: 1, max: @product.total_on_hand",
#                      original:         nil)
#

Deface::Override.new(name:             'add-flex-to-product-page',
                     virtual_path:     'spree/products/show',
                     insert_after:     'div[data-hook="product_show"]',
                     partial:          'products/flex_image',
                     original:         'd70e5231de1ae54406e3f9b732b12679cfcb1374')


Deface::Override.new(name:             'add-xs-to-product-right-part',
                     virtual_path:     'spree/products/show',
                     set_attributes:   'div[data-hook="product_right_part"]',
                     attributes:       { class: 'col-md-8 col-sm-7 col-xs-12' },
                     original:         nil)

#######################################################################################
### The next few overrides handle re-arranging product attributes in cart-form ########
Deface::Override.new(name:             'place-product-desc',
                     virtual_path:     'spree/products/show',
                     insert_after:     'div[data-hook="lifestyle_main"]',
                     cut:              'div[data-hook="description"]',
                     original:         nil, disabled: false)
                     
Deface::Override.new(name:             'format-product-desc',
                     virtual_path:     'spree/products/show',
                     replace_contents: 'div[data-hook="description"]',
                     text:             '<p class="description-block"><%= product_description(@product) %></p>',
                     original:         nil)


Deface::Override.new(name:             'add-centered-to-product-desc',
                     virtual_path:     'spree/products/show',
                     set_attributes:   'div[data-hook="description"]',
                     attributes:       { class: 'well text-center' },
                     original:         nil)
