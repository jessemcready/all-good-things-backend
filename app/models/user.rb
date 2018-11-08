class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followers, through: :relationships, :foreign_key => :follower_id
  has_many :followees, through: :relationships, :foreign_key => :followee_id

end
