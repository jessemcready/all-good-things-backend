class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :posts, :likes, :comments, :followers, :followees, :created_at, :updated_at

  def followers
    relationships = Relationship.all.where(follower_id: object.object.id)
    relationships.map do |relationship|
      {
        id: relationship.followee.id,
        name: relationship.followee.name,
        email: relationship.followee.email
      }
    end
  end

  def followees
    relationships = Relationship.all.where(followee_id: object.object.id)
    relationships.map do |relationship|
      {
        id: relationship.follower.id,
        name: relationship.follower.name,
        email: relationship.follower.email
      }
    end
  end

end
