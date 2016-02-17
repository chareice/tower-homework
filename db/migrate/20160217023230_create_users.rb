class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, index: true
      t.string :email
      t.string :password_digest, :length => 72
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
