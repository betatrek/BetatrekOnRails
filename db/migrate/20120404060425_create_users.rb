class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin
      t.string :uid
      t.string :confirmation_code
      t.string :country
      t.string :state
      t.string :remember_token

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :uid, unique: true
    add_index :users, :confirmation_code
    add_index :users, :remember_token
  end
end
