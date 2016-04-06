Deface::Override.new(name:         'landing-products',
                     virtual_path: 'spree/home/index',
                     replace:      '[data-hook="homepage_products"]',
                     partial:      'welcome/hello')


Deface::Override.new(name: 'landing-sidebar',
                     virtual_path: 'spree/home/index',
                     remove: '[data-hook="homepage_sidebar_navigation"]')


Deface::Override.new(name:         'under-construction',
                     virtual_path: 'spree/layouts/spree_application',
                     replace:      'div#content',
                     partial:      'welcome/hello')
            