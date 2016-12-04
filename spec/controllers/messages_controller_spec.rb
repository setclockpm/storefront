require 'rails_helper'

describe MessagesController do

  describe "GET 'create'" do
    it "redirects to the home page upon message sent from homepage." do
      post :create, message: FactoryGirl.attributes_for(:message)
      expect(response).to redirect_to root_url(anchor: 'inquiries-card')
    end
    
    it "redirects to the contact page when submitted from it." do
      post :create, message: FactoryGirl.attributes_for(:message, :extended)
      expect(response).to redirect_to contact_url
    end
  end

end
