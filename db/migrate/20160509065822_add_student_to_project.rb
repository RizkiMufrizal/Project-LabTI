class AddStudentToProject < ActiveRecord::Migration
  def change
    add_column :projects, :student_npm, :string, index: true, limit: 8
    add_foreign_key :projects, :students, column: :student_npm, primary_key: 'npm', on_delete: :cascade, on_update: :cascade
  end
end
