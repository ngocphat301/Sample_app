class User < ApplicationRecord
  before_save :email_downcase
  validates :name, presence: true,
    length: {maximum: Settings.user.name_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email_maximum},
    format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password_minimum}

  def self.digest string
    if cost = ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def downcase_email
    email.downcase!
  end
end
