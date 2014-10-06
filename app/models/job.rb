class Job < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 20 }

  geocoded_by :location
  after_validation :geocode, if: :address_changed?
end
