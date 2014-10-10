class User < ActiveRecord::Base
  has_many :jobs, foreign_key: 'employer_id', dependent: :destroy
  has_many :user_skill_associations
  has_many :skills, through: :user_skill_associations

  validates :user_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :address

  after_validation :geocode, if: :address_changed?

  include PgSearch
  # multisearchable against: [:user_name, :first_name, :last_name, :address]

   pg_search_scope :combined_search,
                  :against => [:first_name, :last_name, :user_name]

  extend ::Geocoder::Model::ActiveRecord

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(uid: auth_hash[:uid], provider: auth_hash[:provider]) do |user|
      user.user_name = auth_hash[:info][:email]
      user.avatar_url = auth_hash[:info][:image]
      user.first_name = auth_hash[:info][:first_name]
      user.last_name = auth_hash[:info][:last_name]
    end
  end
end
