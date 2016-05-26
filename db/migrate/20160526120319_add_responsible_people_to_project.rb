class AddResponsiblePeopleToProject < ActiveRecord::Migration
  def change
    add_column :projects, :responsibles_id_assistant, :string, index: true, limit: 150
    add_foreign_key :projects, :responsibles, column: :responsibles_id_assistant, primary_key: 'id_assistant', on_delete: :cascade, on_update: :cascade
  end
end
