class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }

  has_many :posts, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :relationships
  has_many :followers, through: :relationships, :foreign_key => :follower_id, dependent: :destroy
  has_many :followees, through: :relationships, :foreign_key => :followee_id, dependent: :destroy

end
