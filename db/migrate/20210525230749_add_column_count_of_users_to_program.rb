class AddColumnCountOfUsersToProgram < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :count_of_users, :bigint, default: 0
  end
end
