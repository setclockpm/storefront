# Deface::Override.new(name:             'landing-products',
#                      virtual_path:     'spree/home/index',
#                      remove:           '[data-hook="homepage_products"]',
#                      original:         '461aae32b5912b8551fcf3a823427507f434a0cc')

# Deface::Override.new(name:             'landing-sidebar',
#                      virtual_path:     'spree/home/index',
#                      remove:           '[data-hook="homepage_sidebar_navigation"]',
#                      original:         'd9a21ccc62b9787b5b2f24d6baf226dba776e4a3')


# Deface::Override.new(name:             'search-button',
#                      virtual_path:     'spree/shared/_search',
#                      replace_contents: 'input[type="submit"]',
#                      original:         nil)

Deface::Override.new(name:             'remove-search-type',
                     virtual_path:     'spree/shared/_search',
                     remove:           "erb[loud]:contains('departments')",
                     original:         'c00d67dfc0496d21a351b48c41a728412cb5ed2c')


Deface::Override.new(name:             'user-login-panel',
                     virtual_path:     'spree/shared/_login',
                     insert_before:    'li#search-bar',
                     partial:          'spree/shared/login_bar',
                     original:         'eb3fa668cd98b6a1c75c36420ef1b238a1fc55ad', disabled: false)


Deface::Override.new(name:             'add-web-font',
                     virtual_path:     'spree/layouts/spree_application',
                     insert_bottom:    'head',
                     text:             '<link href="//fonts.googleapis.com/css?family=Didact+Gothic" rel="stylesheet" type="text/css">',
                     original:         '3238a36183f493276bda180ca7b3430fb0cde007') 



# Deface::Override.new(name:             'replace-header-with-nav',
#                      virtual_path:     'spree/shared/_header',
#                      replace_contents: 'div#spree-header',
#                      partial:          'storefront/header',
#                      original:         '49eaf0408714e76c02811a1895ac7ad379576a56')
#

Deface::Override.new(name:             'remove-space-in-paginator-class',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     replace_contents: "erb[silent]:contains('||=')",
                     text:             'pagination_class = "pagination" || "pagination #{pagination_class}"',
                     original:         'a437e9032cedca47659f662537ff8a7adc8f8f45')


Deface::Override.new(name:             'remove-ul-pagination',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     remove:           'ul',
                     original:         'd9a21ccc62b9787b5b2f24d6baf226dba776e4a3')


Deface::Override.new(name:             'style-paginator',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     insert_after:     "erb[loud]:contains('paginator.render')",
                     partial:          'products/pagination',
                     original:         '51091af81500c8b8fcbc615dabf998b2b0cad4e3')


Deface::Override.new(name:             'style-paginator-outer-window',
                     virtual_path:     'spree/shared/_products',
                     replace_contents: "erb[loud]:contains('twitter-bootstrap-3')",
                     text:             "paginate products, window: 2, theme: 'twitter-bootstrap-3'",
                     original:         nil)


Deface::Override.new(name:             'override-storefront-title',
                     virtual_path:     'spree/shared/_head',
                     replace_contents: 'title', 
                     text:             'Porthos Home: <%= title = (controller.controller_name.titleize == "Home" ? 
                                                                  "Shop Boldly For Your Style" : 
                                                                   controller.controller_name.titleize) %>',
                     original:         '6c51b34d058f87d10add34374293afce2bf817e2')

