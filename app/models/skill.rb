class Skill < ActiveRecord::Base
  has_many :job_skill_associations
  has_many :user_skill_associations
  has_many :users, through: :user_skill_associations
  has_many :jobs, through: :job_skill_associations

  validates :name, presence: true, uniqueness: true
end
