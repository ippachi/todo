class AddDeadLimitToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :dead_limit, :date
    add_index :tasks, :dead_limit
  end
end
