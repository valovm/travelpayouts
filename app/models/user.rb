class User < ApplicationRecord
  has_many :program_users
  has_many :programs, through: :program_users

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
end
