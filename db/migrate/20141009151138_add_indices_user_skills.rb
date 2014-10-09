class AddIndicesUserSkills < ActiveRecord::Migration
  def up
    add_index :user_skill_associations, [:user_id, :skill_id], unique: true
    add_index :job_skill_associations, [:job_id, :skill_id], unique: true
  end

  def down
    remove_index :user_skill_associations, [:user_id, :skill_id]
    remove_index :job_skill_associations, [:job_id, :skill_id]
  end
end
