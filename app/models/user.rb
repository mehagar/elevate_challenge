require 'securerandom'

class User < ApplicationRecord
  has_many :game_events

  before_create :set_auth_token

  validates_presence_of :email, :username, :fullname

  has_secure_password validations: false

  private

  def set_auth_token
    return if auth_token.present?

    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/-/, '')
  end
end
