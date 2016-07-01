module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"


  def color_options(v, options={})
    text = variant_options(v, options={})
    puts "\n#{text}"
    text = text.split(',')[0].gsub!(/Color:/, "").strip
    puts "#{text}\n"
    text
  end

  def current_store
    Spree::Store.first
  end
  
  def home_ip?
    return true if Rails.env.development?
    request.remote_ip == INTERNAL_IP
  end
  
  def relevant_navigation_options
    if current_page?(main_app.root_url)
      render partial: 'layouts/pre_launch_links'
    else
      render partial: 'spree/shared/login_bar' if home_ip?
    end
  end
  
  def search_icon_button_tag
    button_tag(class: 'btn', id: 'search-btn', data: { hook: 'impostor' }) do
      fa_icon 'search'
    end
  end
  
  def title(text)
    content_for(:title) { text }
  end
  
 
  
  def render_search_field
    render partial: 'spree/shared/search' unless current_page?(root_url)
  end
  
end
