class Program < ApplicationRecord
  has_many :program_users
  has_many :users, through: :program_users, counter_cache: :count_of_users

end
