class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.date :due_on
      t.references :owner, index: true

      t.timestamps null: false
    end
    add_foreign_key :projects, :owners
  end
end
