class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.datetime :due_date
      t.integer :weight
      t.integer :progress
      t.integer :priority
      t.integer :required_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
