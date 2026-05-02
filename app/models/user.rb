require "digest/sha1"
require "securerandom"

class User < ApplicationRecord
  has_many :values, dependent: :destroy

  before_save :normalize_email
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def normalize_email
    self.email = email.downcase
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
