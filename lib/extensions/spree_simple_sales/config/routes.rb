Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  
  Spree::Core::Engine.routes.draw do
    get "/sale" => "home#sale"
  end
  
end
