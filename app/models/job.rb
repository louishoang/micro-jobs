class Job < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 20 }
end
