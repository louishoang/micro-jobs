class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
    User.find_or_create_by(uid: auth_hash[:uid], provider: auth_hash[:provider], user_name: auth_hash[:info][:email], avatar_url: auth_hash[:info][:image], first_name: auth_hash[:info][:first_name], last_name: auth_hash[:info][:last_name] )
  end

  validates :user_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
