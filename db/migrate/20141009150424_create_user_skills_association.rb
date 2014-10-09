class CreateUserSkillsAssociation < ActiveRecord::Migration
  def change
    create_table :user_skill_associations do |t|
      t.integer :user_id, null: false
      t.integer :skill_id, null: false

      t.timestamps
    end
  end
end
