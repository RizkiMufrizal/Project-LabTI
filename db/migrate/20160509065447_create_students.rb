class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students, id: false do |t|
      t.primary_key :npm, :string, limit: 8
      t.string :name, limit: 50
      t.string :class, limit: 6
      t.string :gender, limit: 6
      t.text :address

      t.timestamps null: false
    end
  end
end
