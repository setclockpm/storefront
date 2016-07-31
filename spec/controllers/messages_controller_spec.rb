require 'rails_helper'

describe MessagesController do

  describe "GET 'create'" do
    it "redirects to the home page upon message sent." do
      post :create, message: FactoryGirl.attributes_for(:message)
      expect(response).to redirect_to root_url(anchor: 'contact')
    end
  end

end
