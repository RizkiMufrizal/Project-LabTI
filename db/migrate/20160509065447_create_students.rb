class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students, id: false do |t|
      t.primary_key :npm, :string, limit: 8
      t.string :name, limit: 50
      t.string :class_name, limit: 6
      t.string :gender, limit: 6
      t.text :address
      t.string :password_hash, limit: 150
      t.string :password_salt, limit: 150
      t.boolean :enable
      t.string :role, limit: 20

      t.timestamps null: false
    end
  end
end
