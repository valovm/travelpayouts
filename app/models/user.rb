class User < ApplicationRecord
  has_many :program_users
  has_many :programs, through: :program_users
end
