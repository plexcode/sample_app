require 'spec_helper'

describe "LayoutLinks" do

  # integration tests
  describe "LayoutLinks" do

    # home page tests
    it "should have Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end

    # contact page tests
    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

    # about page tests
    it "should have a About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end

    # help page tests
    it "should have a Help page at '/help'" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end

    # signup page tests
    it "should have a signup page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
    end

  end
end
