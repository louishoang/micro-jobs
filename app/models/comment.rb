class Comment < ActiveRecord::Base
  belongs_to :user

  validates :author, presence: true
  validates :text, presence: true
  validates :user_id, presence: true
end
