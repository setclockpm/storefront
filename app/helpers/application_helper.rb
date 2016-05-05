module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"


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
  
  def title(text)
    content_for(:title) { text }
  end
  
end
