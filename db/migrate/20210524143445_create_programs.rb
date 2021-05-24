class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string :title, null: false
      t.string :description

      t.timestamps
    end
  end
end
