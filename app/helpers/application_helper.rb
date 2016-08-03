module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"


  def color_options(v, options={})
    text = variant_options(v, options={})
    # puts "\ntext: #{text}"
#     text = text.split(',')[0].gsub!(/Color:/, "").strip
#     puts "text: #{text}\n"
#     text
  end

  def current_store
    Spree::Store.first
  end
  
  def home_ip?
    return true if Rails.env.development?
    request.remote_ip == INTERNAL_IP
  end
  
  def navbar_behavior
    "navbar-#{current_page?(main_app.root_url) ? "fixed" : "static"}-top"
  end
  
  def navbar_page
    current_page?(main_app.root_url) ? "transparent" : "opaque"
  end
  
  def search_icon_button_tag
    content_tag :div, class: 'col-xs-2 form-group', data: { hook: 'impostor-btn'} do
      button_tag fa_icon('search'), class: 'btn', id: 'search-btn'
    end
  end
  
  def title(text)
    content_for(:title) { text }
  end
  
 
  
  def render_search_field
    render partial: 'spree/shared/search' unless current_page?(root_url)
  end
  
end
