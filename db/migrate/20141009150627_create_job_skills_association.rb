class CreateJobSkillsAssociation < ActiveRecord::Migration
  def change
    create_table :job_skill_associations do |t|
      t.integer :job_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
