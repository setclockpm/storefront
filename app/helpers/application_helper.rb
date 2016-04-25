module ApplicationHelper
  INTERNAL_IP = "108.209.219.227"


  def current_store
    Spree::Store.first
  end
  
  def title(text)
    content_for(:title) { text }
  end
end
