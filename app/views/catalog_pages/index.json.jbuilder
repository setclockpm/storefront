json.array!(@catalog_pages) do |catalog_page|
  json.extract! catalog_page, :id, :image, :position
  json.url catalog_page_url(catalog_page, format: :json)
end
