require 'spec_helper'

describe WelcomeController do

  describe "GET 'hello'" do
    it "returns http success" do
      get 'hello'
      response.should be_success
    end
  end

end
