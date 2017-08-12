class AddCategoryToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :category, :integer, default: 0
    add_index :tasks, :category
  end
end
