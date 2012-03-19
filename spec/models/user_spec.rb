require 'spec_helper'

describe User do

  # set @attribute before each test
  before(:each) do
    @attr = { :name => "example user", :email => "user@example.com"}
  end

  # create a record.  the ! at the end of the create
  # method causes an exception to be raised on failure
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  # the test as written here cause rspec to show that there
  # is a pending test.  this is for the case when you don't
  # know exactly what to test yet but you know a test is needed
  #it "should require a name"


  # name tests #######################################
  # blank name
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  # name length
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  # email tests #######################################
  # blank email
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  # email valid format
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  # email invalid format
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  # email should be unique
  it "should reject duplicate email addresses" do
    # put a user with current email into the db
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  # check that different case emails are unigue
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

end
