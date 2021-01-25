class User < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
  length: {maximum: Settings.user.email.max_length},
  format: {with: VALID_EMAIL_REGEX}
  before_save :downcase_email
  private
  def downcase_email
    email.downcase!
  end
  has_secure_password
end