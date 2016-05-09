class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.primary_key :email, :string, limit: 50
      t.string :password_hash, limit: 150
      t.string :password_salt, limit: 150
      t.boolean :enable
      t.string :role, limit: 20

      t.timestamps null: false
    end
  end
end
