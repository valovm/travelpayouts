class CreateProgramUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :program_users do |t|
      t.belongs_to :user
      t.belongs_to :program
      t.timestamps
    end

    add_index :program_users, %i[user_id program_id], unique: true
  end
end
