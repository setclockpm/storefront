# Deface::Override.new(name:             'landing-products',
#                      virtual_path:     'spree/home/index',
#                      remove:           '[data-hook="homepage_products"]',
#                      original:         '461aae32b5912b8551fcf3a823427507f434a0cc')


# Deface::Override.new(name:             'user-login-panel',
#                      virtual_path:     'spree/shared/_login',
#                      insert_before:    'li#search-bar',
#                      partial:          'spree/shared/login_bar',
#                      original:         'eb3fa668cd98b6a1c75c36420ef1b238a1fc55ad', disabled: false)


Deface::Override.new(name:             'landing-sidebar',
                     virtual_path:     'spree/home/index',
                     remove:           '[data-hook="homepage_sidebar_navigation"]',
                     original:         'd9a21ccc62b9787b5b2f24d6baf226dba776e4a3')
                     
                     
Deface::Override.new(name:             'replace-header-with-nav',
                     virtual_path:     'spree/shared/_header',
                     replace_contents: 'div#spree-header',
                     partial:          'storefront/header',
                     original:         '92c159ac9d2aec631cbdbd556c82b361923d63c5')
            