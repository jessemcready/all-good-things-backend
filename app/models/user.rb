class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, length: { in: 9..25 }
  validates :password, length: { in: 4..20 }
  validates :name, length: { in: 4..35 }

  has_many :posts, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Relationship'
  has_many :followers, through: :follower_follows, source: :follower
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Relationship'
  has_many :followees, through: :follower_follows, source: :followee

end
