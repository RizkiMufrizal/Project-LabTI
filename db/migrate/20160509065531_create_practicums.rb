class CreatePracticums < ActiveRecord::Migration
  def change
    create_table :practicums, id: false do |t|
      t.primary_key :id_practicum, :string, limit: 150
      t.string :practicum_name, limit: 50

      t.timestamps null: false
    end
  end
end
