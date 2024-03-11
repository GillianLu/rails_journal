class AddCategoryToToDos < ActiveRecord::Migration[7.1]
  def change
    add_reference :to_dos, :category, null: false, foreign_key: true

  end
end
