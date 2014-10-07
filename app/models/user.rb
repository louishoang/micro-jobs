class User < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:user_name, :first_name, :last_name, :address]

  extend ::Geocoder::Model::ActiveRecord

  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(uid: auth_hash[:uid], provider: auth_hash[:provider], user_name: auth_hash[:info][:email]) do |user|
      user.avatar_url = auth_hash[:info][:image]
      user.first_name = auth_hash[:info][:first_name]
      user.last_name = auth_hash[:info][:last_name]
    end
  end
  has_many :jobs

  validates :user_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :address

  after_validation :geocode, if: :address_changed?
end
