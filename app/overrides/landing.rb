Deface::Override.new(virtual_path: 'spree/home/index',
            replace: '[data-hook="homepage_products"]',
            name: 'landing-products',
            partial: 'welcome/hello')

    Deface::Override.new(virtual_path: 'spree/home/index',
            name: 'landing-sidebar',
            remove: '[data-hook="homepage_sidebar_navigation"]')