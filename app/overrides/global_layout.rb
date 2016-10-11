# ################################# Deface pseudo doc help ########################################################
# ----------------------------------------------------------------------------------------------------------------
# > deface:get_result
# > rake deface:get_result['spree/products/_cart_form']
# Will list the original contents of a partial or template, the overrides that have been defined for a that file,
# and the resulting markup. get_result takes a single argument which is the virtual path of the template / partial:
# Run it to verify that your override is actually referencing something.





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

Deface::Override.new(name:              'surround-with-canvas-div-1',
                     virtual_path:      'spree/layouts/spree_application',
                     surround_contents: "body",
                     text:              '<div canvas="container" style="margin:0;padding:0;"><%= render_original %></div>')

Deface::Override.new(name:             'hide-sidebar',
                     virtual_path:     'spree/products/index',
                     set_attributes:   'div[data-hook="homepage_sidebar_navigation"]',
                     attributes:       { class: 'hidden' },
                     original:         nil)

Deface::Override.new(name:             'set-content-div-dom-class',
                     virtual_path:     'spree/layouts/spree_application',
                     set_attributes:   'div#content',
                     attributes:       { class: 'col-xs-12' },
                     original:         nil)

# Deface::Override.new(name:             'add-canvas-to-container',
#                      virtual_path:     'spree/layouts/spree_application',
#                      set_attributes:   'div.container',
#                      attributes:       { class: 'container', canvas: 'container' },
#                      original:         nil)
                     
Deface::Override.new(name:             'include-slidebar-partial',
                     virtual_path:     'spree/layouts/spree_application',
                     insert_bottom:    'body',
                     partial:         'layouts/shared/slidebar_menu',
                     original:         nil)



#######################################################################################
### The next few overrides handle product index styling ###############################
Deface::Override.new(name:             'remove-product-name-from-index',
                     virtual_path:     'spree/shared/_products',
                     remove:           'erb[loud]:contains(\'itemprop: "name"\')',
                     original:         '6b0e20b504a733691837a40ded21582a15b114ab')
                     
                     
# Deface::Override.new(name:             'remove-br-from-product-index',
#                      virtual_path:     'spree/shared/_products',
#                      remove:           'br',
#                      original:         '01298c01639d867f841df8043cedc891cf11d8f0')
#######################################################################################


## This is to make header like the one on the landing page
Deface::Override.new(name:             'replace-header-with-nav',
                     virtual_path:     'spree/shared/_header',
                     replace_contents: 'div#spree-header',
                     partial:          'layouts/shared/main_header_nav',
                     original:         '49eaf0408714e76c02811a1895ac7ad379576a56')





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







#######################################################################################
### The next few overrides handle styling of everything in the header/nav #############
Deface::Override.new(name:             'add-xs-to-figure-logo',
                     virtual_path:     'spree/shared/_header',
                     set_attributes:   'figure#logo',
                     attributes:       { class: 'logo' },
                     original:         'dc8363cba7a94682be7f3a2b970c6512b4745d26')
                     
Deface::Override.new(name:             'add-xs-col-to-nav',
                     virtual_path:     'spree/shared/_nav_bar',
                     set_attributes:   'nav#top-nav-bar',
                     attributes:       { class: 'navbar col-md-8 col-sm-9 col-xs-3' },
                     original:         nil)
                     
Deface::Override.new(name:             'override-storefront-title',
                     virtual_path:     'spree/shared/_head',
                     replace_contents: 'title', 
                     text:             'Porthos Home: <%= title = (controller.controller_name.titleize == "Home" ? 
                                                                  "Shop Boldly For Your Style" : 
                                                                   controller.controller_name.titleize) %>',
                     original:         '6c51b34d058f87d10add34374293afce2bf817e2')
#######################################################################################








#######################################################################################
### The next overrides deal with displaying the taxonomies ############################
Deface::Override.new(name:             'remove-shop-by-from-sidebar',
                     virtual_path:     'spree/shared/_taxonomies',
                     replace_contents: "erb[loud]:contains(':shop_by_taxonomy')",
                     text:             'taxonomy.name',
                     original:         '494793b73e32108d498c4db30ba069dd97e2f972')
#######################################################################################
