class RemoveSkillId < ActiveRecord::Migration
  def up
    remove_column :users, :skill_id
    remove_column :jobs, :skill_id
  end

  def down
    add_column :users, :skill_id, :integer
    add_column :jobs, :skill_id, :integer
  end
end
