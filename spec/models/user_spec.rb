require 'spec_helper'

describe User do


  # set @attribute before each test
  before(:each) do
    @attr = { :name     => "example user",
              :email    => "user@example.com",
              :password => "testtest",
              :password_confirmation => "testtest"
              }
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

  # password validations ###################################
  describe "password validations" do

  # password required
    it "should require a password" do
      User.new(@attr.merge( :pasword => "",
                            :password_confirmation => ""
                           )
              ).should_not be_valid
    end

    # password and confirmation has to match
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")
              ).should_not be_valid
    end

    # password should be greater than 5 characters
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:pasword => short,
                         :password_confimation => short)
      User.new(hash).should_not be_valid
    end

    # password should have max of 40 characters
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long,
                         :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

  end

  # password encryption
  describe "password encryption" do

    # create a user to get an encrypted password
    before(:each) do
      @user = User.create!(@attr)
    end

    # check that password is encrypted
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    # encrypted password should be created on create!
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  end

     #
  describe "has_password? method" do

      
    it "should be true if the passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end

    #
    it "should be false if the passwords don't match" do
      @user.has_password?("invalid").should be_false
    end

    describe "authenticate method" do
      
      #
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
      end

      #
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      #
      it "should return the user on emai/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
      end
    end
  end

end
