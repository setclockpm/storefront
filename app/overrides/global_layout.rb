# Deface::Override.new(name:             'landing-products',
#                      virtual_path:     'spree/home/index',
#                      remove:           '[data-hook="homepage_products"]',
#                      original:         '461aae32b5912b8551fcf3a823427507f434a0cc')

# Deface::Override.new(name:             'landing-sidebar',
#                      virtual_path:     'spree/home/index',
#                      remove:           '[data-hook="homepage_sidebar_navigation"]',
#                      original:         'd9a21ccc62b9787b5b2f24d6baf226dba776e4a3')








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







#######################################################################################
### The next few overrides handle product index styling ###############################
Deface::Override.new(name:             'remove-product-name-from-index',
                     virtual_path:     'spree/shared/_products',
                     remove:           'erb[loud]:contains(\'itemprop: "name"\')',
                     original:         '6b0e20b504a733691837a40ded21582a15b114ab')
                     
                     
Deface::Override.new(name:             'remove-br-from-product-index',
                     virtual_path:     'spree/shared/_products',
                     remove:           'br',
                     original:         '01298c01639d867f841df8043cedc891cf11d8f0')
#######################################################################################


### This is to make header like the one on the landing page
# Deface::Override.new(name:             'replace-header-with-nav',
#                      virtual_path:     'spree/shared/_header',
#                      replace_contents: 'div#spree-header',
#                      partial:          'storefront/header',
#                      original:         '49eaf0408714e76c02811a1895ac7ad379576a56')
#




#######################################################################################
### The next few overrides handle pagination styling ##################################
Deface::Override.new(name:             'remove-space-in-paginator-class',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     replace_contents: "erb[silent]:contains('||=')",
                     text:             'pagination_class = "pagination" || "pagination #{pagination_class}"',
                     original:         'a437e9032cedca47659f662537ff8a7adc8f8f45')


Deface::Override.new(name:             'remove-ul-pagination',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     remove:           'ul',
                     original:         '56f01b0cfaa3bf9d7b06ec490c35f5167bc41c1d')


Deface::Override.new(name:             'style-paginator',
                     virtual_path:     'kaminari/twitter-bootstrap-3/_paginator',
                     insert_after:     "erb[loud]:contains('paginator.render')",
                     partial:          'products/pagination',
                     original:         '51091af81500c8b8fcbc615dabf998b2b0cad4e3')


Deface::Override.new(name:             'style-paginator-outer-window',
                     virtual_path:     'spree/shared/_products',
                     replace_contents: "erb[loud]:contains('twitter-bootstrap-3')",
                     text:             "paginate products, window: 2, theme: 'twitter-bootstrap-3'",
                     original:         'dd04b21b55fdc5d89eaddc544554f13508c67bac')
#######################################################################################











Deface::Override.new(name:             'override-storefront-title',
                     virtual_path:     'spree/shared/_head',
                     replace_contents: 'title', 
                     text:             'Porthos Home: <%= title = (controller.controller_name.titleize == "Home" ? 
                                                                  "Shop Boldly For Your Style" : 
                                                                   controller.controller_name.titleize) %>',
                     original:         '6c51b34d058f87d10add34374293afce2bf817e2')

