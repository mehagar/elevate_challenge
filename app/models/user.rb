class User < ApplicationRecord
  validates_presence_of :email, :username, :fullname

  has_secure_password validations: false
end
