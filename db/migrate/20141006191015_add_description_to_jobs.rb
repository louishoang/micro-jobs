class AddDescriptionToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :description, :text, null: false
  end

  def down
    remove_column :jobs, :description
  end
end
