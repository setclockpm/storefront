class ApplicationController < ActionController::Base
  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Order
  helper Spree::BaseHelper
  helper Spree::StoreHelper
  
  before_action :load_taxonomies
  protect_from_forgery
  
  
  def current_currency
    Spree::Config[:currency]
  end
  
  def current_order_params
    { currency: current_currency, guest_token: cookies.signed[:guest_token], store_id: Spree::Store.first, user_id: try_spree_current_user.try(:id) }
  end
  
  
  
  private
    def load_taxonomies
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
  
end
