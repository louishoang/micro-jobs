class Job < ActiveRecord::Base
  include PgSearch

  pg_search_scope :combined_search,
                  :against => [:name, :description],
                  :using => { :trigram => { :threshold => 0.1 },
                    :tsearch  => { :dictionary => "english",
                                :prefix => true,
                                :any_word => true
                                }}

  extend ::Geocoder::Model::ActiveRecord

  has_many :job_skill_associations
  has_many :skills, through: :job_skill_associations
  belongs_to :employer, class_name: "User"

  validates :employer, presence: true
  # validates :skill, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 20 }
  validates :description, presence: true, length: {minimum: 50}

  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
