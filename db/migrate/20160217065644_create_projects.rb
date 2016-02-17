class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.timestamps null: false
    end
    add_reference :projects, :team, index: true, foreign_key: true
  end
end
