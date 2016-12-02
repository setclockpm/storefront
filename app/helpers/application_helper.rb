module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"

  
  def color_options(v, options={})
    text = variant_options(v, options={})
  end

  def current_store
    Spree::Store.first
  end
  
  def currently_at(tab)
    render partial: 'layouts/shared/main_nav', locals: { current_tab: tab }
  end
  
  def home_ip?
    return true if Rails.env.development?
    request.remote_ip == INTERNAL_IP
  end
  
  def nav_tab(title, url, options={})
    current_tab = options.delete(:current)
    options[:class] = (current_tab == title) ? 'active nav-item' : 'inactive nav-item'
    content_tag(:li, link_to(title, url), options)
  end

  def required_field
    content_tag :span, '*', class: 'lil-splatty'
  end
  
  def search_icon_button_tag
    content_tag :div, class: 'col-xs-2 form-group', data: { hook: 'impostor-btn'} do
      button_tag fa_icon('search'), class: 'btn', id: 'search-btn'
    end
  end
  
  def title(text)
    content_for(:title) { text }
  end

  
end
