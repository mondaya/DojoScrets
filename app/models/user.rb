class User < ActiveRecord::Base

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save :downcase_email

   private
    def downcase_email
      self.email.downcase!
    end

end
