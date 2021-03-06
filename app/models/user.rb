class User < ActiveRecord::Base
  has_many :posts

  validates :password, 
    presence: true,
    on: :create
  validates :email,
    presence: true,
    uniqueness: {:case_sensitive => false},
    :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name,
    presence: true,
    length: {:minimum => 2, :maximum => 20}

  has_secure_password

  def self.authenticate(email, password)
    User.find_by_email(email).try(:authenticate, password)
  end

end
