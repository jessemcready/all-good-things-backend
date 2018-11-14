class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, length: { in: 9..25 }
  validates :password, length: { in: 4..20 }
  validates :name, length: { in: 4..35 }

  has_many :posts, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :relationships
  has_many :followers, through: :relationships, :foreign_key => :follower_id
  has_many :followees, through: :relationships, :foreign_key => :followee_id

end
