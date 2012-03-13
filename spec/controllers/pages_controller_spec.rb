require 'spec_helper'

describe PagesController do

  # note: think this is needed so page content can be tested
  render_views

  # tests for page home
  describe "GET 'home'" do

    # page response validation
    it "should be successful" do
      get 'home'
      response.should be_success #should return sts code 200
    end

    # title validation
    it "check home page title" do
    get 'home'
    response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | Home")
    end

  end


  # tests for contact page
  describe "GET 'contact'" do

    # page response validation
    it "should be successful" do
      get 'contact'
      response.should be_success
    end


    # title validation
    it "check contact page title" do
    get 'contact'
    response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  
  # tests for about page
  describe "GET 'about'" do

    # page response validation
    it "should be sucessful" do
      get 'about'
      response.should be_success
    end


    # title validation
    it "check about page title" do
    get 'about'
    response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | About")
    end

  end

end
