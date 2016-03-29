module ApplicationHelper

  def title(page_title)
    page_title = "Titty Sprinkles"
    content_for(:title) { page_title }
  end
end
