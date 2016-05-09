class AddPracticumToProject < ActiveRecord::Migration
  def change
    add_column :projects, :practicum_id_practicum, :string, index: true, limit: 150
    add_foreign_key :projects, :practicums, column: :practicum_id_practicum, primary_key: 'id_practicum', on_delete: :cascade, on_update: :cascade
  end
end
