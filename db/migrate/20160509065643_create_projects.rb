class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.primary_key :id_project, :string, limit: 150
      t.string :name_project, limit: 50
      t.string :name_file, limit: 150

      t.timestamps null: false
    end
  end
end
