
require 'digest'

class User < ActiveRecord::Base


# attributes available for updates
attr_accessor :password
attr_accessible :name, :email, :password, :password_confirmation

# validations #############################################
# name validations
validates :name, :presence => true,
                 :length   => { :maximum => 50 }

# email validations
email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, :presence   => true,
                  :format     => { :with => email_regex },
                  :uniqueness => { :case_sensitive => false }

# password validations
validates :password, :presence     => true,
                     :confirmation => true,
                     :length       => { :within => 6..40 }

# encrypt the password
before_save :encrypt_password


# public methods###########################################
def has_password?(submitted_password)
  encrypted_password == encrypt(submitted_password)
end

def self.authenticate(email, submitted_password)
  user = find_by_email(email)
  return nil if user.nil?
  return user if user.has_password?(submitted_password)
end


# private methods##########################################
private


  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
