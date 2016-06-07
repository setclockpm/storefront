# Deface::Override.new(name:         'move-header',
#                      virtual_path: 'spree/layouts/spree_application',
#                      insert_before: "div.container", cut: "erb[loud]:contains('spree/shared/header')",
#                      original:      'c5300405404a01ada5323e7942bdfc6a11cae3a4')

#
# Deface::Override.new(name:              'wrap-header',
#                      virtual_path:      'spree/shared/_header',
#                      surround_contents: 'header#header', text: '<%= render_original %>',
#                      original:          'ae44d1359446708c4148d6bfdf888ad1e68e2db2')


# Deface::Override.new(name:         'add-home-link',
#                      virtual_path: 'spree/shared/_nav_bar',
#                      insert_top:   'ul#nav-bar', text: '<li id="home-link" data-hook><%= link_to t(:home), root_path %></li>',
#                      original:     '7d953d8fbc78806fc43a08f52d2bb3a52f4a0086')


Deface::Override.new(name:          'add-cart',
                     virtual_path:  'spree/shared/_nav_bar',
                     insert_bottom: 'ul#nav-bar', text: '<li id="link-to-cart" data-hook><%= link_to_cart %></li>',
                     original:      '0edddc156c3563a5a866d9d5ccfbc0bfdbe522c0')

#
# Deface::Override.new(name:         'remove-home-from-main-nav',
#                      virtual_path: 'spree/shared/_main_nav_bar',
#                      remove:       'li#home-link',
#                      original:     '79d342a6fd7281d8499d3a5ee5480f416f733e98')
#
#
# Deface::Override.new(name:         'remove-cart-from-main-nav',
#                      virtual_path: 'spree/shared/_main_nav_bar',
#                      remove:       'li#link-to-cart',
#                      original:     'e9241f273349c0f080cef375ce5d2c26546eb870')

#
# Deface::Override.new(name:         'move-main-nav',
#                      virtual_path: 'spree/shared/_header',
#                      insert_after: '#header', partial: 'spree/shared/main_nav_bar',
#                      original:     'ca82a13623f1a645e0df4c8eb9c9ecc6df293a0c')
#
#
# Deface::Override.new(name:         'remove-search-type',
#                      virtual_path: 'spree/shared/_search',
#                      remove:       "erb[loud]:contains('departments')",
#                      original:     'c00d67dfc0496d21a351b48c41a728412cb5ed2c')
# #
# #
# Deface::Override.new(name:         'remove-main-nav-from-tsop',
#                      virtual_path: 'spree/shared/_header',
#                      remove:       "erb[loud]:contains('main_nav_bar')",
#                      original:     'a9048f77da7d72d4e5de640cff1c0516a8aabe6a')

#
# Deface::Override.new(name:              'wrap-main-nav',
#                      virtual_path:      'spree/shared/_main_nav_bar',
#                      surround_contents: 'nav.columns', text: '<div class="container"><%= render_original %></div>')
#
#
# Deface::Override.new(name:         'search-main-nav-move',
#                      virtual_path: 'spree/shared/_main_nav_bar',
#                      insert_after: '#main-nav-bar',
#                      text:
# '<% @taxons = @taxon && @taxon.parent ? @taxon.parent.children : Spree::Taxon.roots %>
# <%= form_tag products_path, method: :get, id: "main-search-form" do %>
#   <%= select_tag :taxon, options_for_select([[t(:all_departments), '']] + @taxons.map {|t| [t.name, t.id]}, @taxon ? @taxon.id : params[:taxon]) %>
#   <%= search_field_tag :keywords, params[:keywords], placeholder: t(:search) %>
#   <%= submit_tag t(:search), name: nil, id: "main-search-button" %>
# <% end %>',
#                      original:     'a28864aec332a3e503785422423271798d609354')
#
#
#


# products
# Deface::Override.new(name:          'move-product-title-above-image',
#                      virtual_path:  'spree/shared/_products',
#                      insert_before: 'div.product-image',
#                      cut:           "erb[loud]:contains('link_to truncate(product.name, length: 50)')")
#
#
# Deface::Override.new(name:         'gradient-overlay-to-products',
#                      virtual_path: 'spree/shared/_products',
#                      insert_after: "span.price.selling", text: "<span class='overlay'></span>",
#                      original:     '10eb9a198f4f0938e075ba8f41c4a73a1b6a77e4')
