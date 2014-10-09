class JobSkillAssociation < ActiveRecord::Base
  belongs_to :job
  belongs_to :skill

  validates :job, presence: true
  validates :skill, presence: true
end
