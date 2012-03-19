require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do

    # new user page response
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    # check for correct title
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign Up")
    end
  end

end
