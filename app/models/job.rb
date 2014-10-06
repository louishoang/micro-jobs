require 'elasticsearch/model'

class Job < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user

  validates :employer_id, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 20 }
  validates :description, presence: true, length: {minimum: 50}

  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
