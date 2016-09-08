module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"


  def color_options(v, options={})
    text = variant_options(v, options={})
  end
  
  def current_request?(*requests)
    requests.each do |request|
      if request[:controller] == controller.controller_name
        return true if request[:action].is_a?(Array) && request[:action].include?(controller.action_name)
        return true if request[:action] == controller.action_name
      end
    end
    false
  end

  def current_store
    Spree::Store.first
  end
  
  def home_ip?
    return true if Rails.env.development?
    request.remote_ip == INTERNAL_IP
  end
  
  def inquiries_form_validation
    if request && request.get?
      current_page?(main_app.contact_path) ? (return 'long_form_validation') : (return 'messages/short_form_validation')
    end
    params[:subject] ? 'long_form_validation' : 'messages/short_form_validation'
  end
  
  def navbar_behavior
    "navbar-#{current_page?(main_app.root_url) ? "fixed" : "static"}-top"
  end
  
  def navbar_page
    unless request
      raise "View context has not provided a Request object! #navbar_page"
    end
    
    if request.get?
      puts "current_page?(main_app.root_url): #{current_page?(main_app.root_url)}\n"
      current_page?(main_app.root_url) ? "transparent" : "opaque"
    else
      request.original_url.end_with?(main_app.root_url) ? "transparent" : "opaque"
    end
  end
  
  def render_subject_dropdown(f)
    if request && request.get?
      return unless current_page?(main_app.contact_path)
    else
      return unless params[:subject]
    end
    render partial: "subject", locals: { f: f }
  end
  
  def required_field
    content_tag :span, '*', class: 'foo'
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
