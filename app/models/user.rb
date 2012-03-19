class User < ActiveRecord::Base

# attributes available for updates
attr_accessible :name, :email

# name validations
validates :name, :presence => true,
                 :length   => { :maximum => 50 }

# email validations
email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, :presence   => true,
                  :format     => { :with => email_regex },
                  :uniqueness => { :case_sensitive => false }

end
