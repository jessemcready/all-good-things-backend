class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }

  has_many :posts
  has_many :likes
  has_many :comments
  has_many :relationships
  has_many :followers, through: :relationships, :foreign_key => :follower_id
  has_many :followees, through: :relationships, :foreign_key => :followee_id

end
