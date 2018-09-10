class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true,
    length: {maximum: Settings.user.name_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email_maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.user.password_minimum}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
