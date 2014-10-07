class AddSkillIdToUser < ActiveRecord::Migration
  def up
    add_column :users, :skill_id, :integer
  end

  def down
    remove_column :users, :skill_id
  end
end
