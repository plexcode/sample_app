require 'spec_helper'

describe PagesController do

  # note: think this is needed so page content can be tested
  render_views

  # following block is reun before each described test??
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

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
    response.should have_selector("title", :content => @base_title + " | Home")
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
    response.should have_selector("title", :content => @base_title + " | Contact")
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
    response.should have_selector("title", :content => @base_title + " | About")
    end

  end


    # tests for help page
  describe "GET 'help'" do

    # page response validation
    it "should be sucessful" do
      get 'help'
      response.should be_success
    end


    # title validation
    it "check about page title" do
    get 'help'
    response.should have_selector("title", :content => @base_title + " | Help")
    end

  end

end
