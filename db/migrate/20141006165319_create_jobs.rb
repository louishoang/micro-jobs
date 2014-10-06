class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name, null: false
      t.string :location
      t.float :budget
      t.integer :employer_id, null: false
      t.integer :employee_id
      t.boolean :awarded, default: false, null: false
      t.integer :skill_id, null: false

      t.timestamps
    end
  end
end
