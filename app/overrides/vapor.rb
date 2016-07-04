
#######################################################################################
### Moves nav below header (lighter colored) ##########################################
Deface::Override.new(name:         'move-main-nav',
                     virtual_path: 'spree/shared/_header',
                     insert_after: '#header', partial: 'spree/shared/main_nav_bar',
                     original:     '11e5d2124a8a7d4e098c3188583bd42dc7d39d1e')

Deface::Override.new(name:         'remove-home-from-main-nav',
                     virtual_path: 'spree/shared/_main_nav_bar',
                     remove:       'li#home-link',
                     original:     '79d342a6fd7281d8499d3a5ee5480f416f733e98')
#######################################################################################
                     
                     
                     


#######################################################################################
### The next 2 overrides move cart from _main_nav_bar to larger upper header ##########
Deface::Override.new(name:         'remove-cart-from-main-nav',
                     virtual_path: 'spree/shared/_main_nav_bar',
                     remove:       'li#link-to-cart',
                     original:     'e9241f273349c0f080cef375ce5d2c26546eb870')
                     
                     
Deface::Override.new(name:          'add-cart',
                     virtual_path:  'spree/shared/_nav_bar',
                     insert_bottom: 'ul#nav-bar', text: '<li id="link-to-cart" data-hook="impostor"><%= link_to_cart %></li>',
                     original:      '1170787a8324f3d51ed38d88567888db33a333be')
#######################################################################################


#######################################################################################
### The next overrides deal with displaying the taxonomies ############################
Deface::Override.new(name:             'remove-shop-by-from-sidebar',
                     virtual_path:     'spree/shared/_taxonomies',
                     replace_contents: "erb[loud]:contains(':shop_by_taxonomy')",
                     text:             'taxonomy.name',
                     original:         '494793b73e32108d498c4db30ba069dd97e2f972')
#######################################################################################
# Deface::Override.new(name:         'move-header',
#                      virtual_path: 'spree/layouts/spree_application',
#                      insert_before: "div.container", cut: "erb[loud]:contains('spree/shared/header')",
#                      original:      'c5300405404a01ada5323e7942bdfc6a11cae3a4')
#
#
# Deface::Override.new(name:              'wrap-header',
#                      virtual_path:      'spree/shared/_header',
#                      surround_contents: 'header#header', text: '<%= render_original %>',
#                      original:          'ae44d1359446708c4148d6bfdf888ad1e68e2db2')
#
#





#######################################################################################
### The next 2 overrides style search form in header ##################################
Deface::Override.new(name:             'search-button-uses-fa-icon-instead',
                     virtual_path:     'spree/shared/_search',
                     replace_contents: "erb[loud]:contains('submit_tag')",
                     text:             'search_icon_button_tag',
                     original:         '70a5fb5b026445f5abc1d47154f9bf0a2783d6b8')

Deface::Override.new(name:             'remove-form-group-divs',
                     virtual_path:     'spree/shared/_search',
                     remove:           "div.form-group",
                     original:         '80ad191fb56f2091f082dae8d8616d8da49c8f77')

Deface::Override.new(name:             'replace-with-needed-form-group-divs',
                     virtual_path:     'spree/shared/_search',
                     insert_before:    "erb[loud]:contains('search_icon_button_tag')",
                     text:             "<div class='col-xs-8 form-group' data-hook='impostor-field'><%= search_field_tag :keywords, params[:keywords], placeholder: Spree.t(:search), class: 'form-control' %></div>",
                     original:         '8cc4852db2d795220964cbe19dcc5ee30cbc8c30')
                     

#######################################################################################





Deface::Override.new(name:         'remove-main-nav-from-tsop',
                     virtual_path: 'spree/shared/_header',
                     remove:       "erb[loud]:contains('main_nav_bar')",
                     original:     'a9048f77da7d72d4e5de640cff1c0516a8aabe6a')


Deface::Override.new(name:              'wrap-main-nav',
                     virtual_path:      'spree/shared/_main_nav_bar',
                     surround_contents: 'nav.columns', 
                     text:              '<div class="container"><%= render_original %></div>')


# Deface::Override.new(name:         'search-main-nav-move',
#                      virtual_path: 'spree/shared/_main_nav_bar',
#                      insert_after: '#main-nav-bar',
#                      text:
# '<% @taxons = @taxon && @taxon.parent ? @taxon.parent.children : Spree::Taxon.roots %>
# <%= form_tag products_path, method: :get, id: "main-search-form", class: "navbar-form" do %>
#   <%= search_field_tag :keywords, params[:keywords], placeholder: t(:search), class: "form-control" %>
#   <%= submit_tag t(:search), name: nil, id: "main-search-button", class: "btn btn-success" %>
# <% end %>',
#                      original:     'a28864aec332a3e503785422423271798d609354')

#
#
#
#
# # products
# Deface::Override.new(name:          'move-product-title-above-image',
#                      virtual_path:  'spree/shared/_products',
#                      insert_before: 'div.product-image',
#                      cut:           "erb[loud]:contains('link_to truncate(product.name, length: 50)')")
#
#   <%= select_tag :taxon, options_for_select([[t(:all_departments), '']] + @taxons.map {|t| [t.name, t.id]}, @taxon ? @taxon.id : params[:taxon]) %>
#
#
# Deface::Override.new(name:         'gradient-overlay-to-products',
#                      virtual_path: 'spree/shared/_products',
#                      insert_after: "span.price.selling", text: "<span class='overlay'></span>",
#                      original:     '10eb9a198f4f0938e075ba8f41c4a73a1b6a77e4')
