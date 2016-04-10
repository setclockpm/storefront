Deface::Override.new(name:           'landing-products',
                     virtual_path:   'spree/home/index',
                     remove:        '[data-hook="homepage_products"]',
                     original:       nil)


Deface::Override.new(name:             'landing-sidebar',
                     virtual_path:     'spree/home/index',
                     remove:           '[data-hook="homepage_sidebar_navigation"]',
                     original:         'd9a21ccc62b9787b5b2f24d6baf226dba776e4a3')


Deface::Override.new(name:             'main-landing-page',
                     virtual_path:     'spree/layouts/spree_application',
                     replace_contents: '[data-hook="body"]',
                     partial:          'welcome/landing_main')
                     
                     
Deface::Override.new(name:             'replace-header-with-nav',
                     virtual_path:     'spree/shared/_header',
                     replace_contents: 'div#spree-header',
                     partial:          'layouts/navigation')
            