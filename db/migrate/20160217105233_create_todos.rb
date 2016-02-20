class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      #任务内容
      t.string :content
      #任务创建人
      t.integer :creator_id
      #任务执行人
      t.integer :executor_id
      #任务状态 进行中 -> 已完成
      t.string :state, index: true, default: 'opened'
      t.timestamps null: false
    end
    add_reference :todos, :project, index: true, foreign_key: true
  end
end
