class UserSkillAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :user, presence: true
  validates :skill, presence: true
end
