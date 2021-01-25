class User < ApplicationRecord
  validates :name, presence: true
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
