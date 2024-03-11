class CreateToDos < ActiveRecord::Migration[7.1]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :deadline
      t.boolean :completed

      t.timestamps
    end
  end
end
