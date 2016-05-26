class CreateResponsibles < ActiveRecord::Migration
  def change
    create_table :responsibles, id: false do |t|
      t.primary_key :id_assistant, :string, limit: 150
      t.string :name, limit: 50
      t.string :phone, limit: 20

      t.timestamps null: false
    end
  end
end
