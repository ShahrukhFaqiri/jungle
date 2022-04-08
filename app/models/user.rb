class User < ActiveRecord::Base
  
  validates_uniqueness_of :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  has_secure_password
  
end