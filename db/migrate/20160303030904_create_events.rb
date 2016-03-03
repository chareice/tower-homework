class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :from
      t.string :to
      t.string :action
      t.string :meta_data

      t.string :actor_name
      t.integer :actor_id

      t.string :target_todo_content
      t.integer :target_todo_id

      t.string :project_name
      t.integer :project_id
      t.timestamps null: false
    end
  end
end
