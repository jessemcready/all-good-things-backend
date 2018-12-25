class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at, :admin, :profile_url, :followers, :followees
  has_many :posts, each_serializer: PostSerializer
  has_many :likes

  def followers
    Relationship.where(follower_id: object.id).map do |relationship|
      user = relationship.followee
      { id: user.id, name: user.name, email: user.email, profile_url: user.profile_url }
    end
  end

end
