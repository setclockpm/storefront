class ApplicationController < ActionController::Base
  #include ShopifyApp::Controller
  before_action :authenticate_user!
  protect_from_forgery
end
