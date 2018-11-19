class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at, :admin, :profile_url
  has_many :posts, each_serializer: PostSerializer
  has_many :likes
  has_many :followers
  has_many :followees

end
