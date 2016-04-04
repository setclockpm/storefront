Deface::Override.new(name:             'override-admin-title',
                     virtual_path:     'spree/admin/shared/_head',
                     replace_contents: 'title', text: 'Porthos Portal - <%= controller.controller_name.titleize %>')


Deface::Override.new(name:             'override-storefront-title',
                     virtual_path:     'spree/shared/_head',
                     replace_contents: 'title', text: 'Porthos Home: 
                                                      <%= title = (controller.controller_name.titleize == "Home" ? 
                                                      "Shop Boldy For Your Style" : 
                                                      controller.controller_name.titleize) %>')