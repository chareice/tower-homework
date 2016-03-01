class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :project, index: true, null: false
      t.timestamps null: false
    end
  end
end
