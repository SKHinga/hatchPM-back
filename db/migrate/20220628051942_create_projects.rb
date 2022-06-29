class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_scope
      t.date :deadline
      t.text :description
      t.string :progress
      t.integer :user_id
      t.timestamps
    end
  end
end
