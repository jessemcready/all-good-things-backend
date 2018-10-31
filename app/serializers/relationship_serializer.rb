class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :follower, :followee, :created_at, :updated_at

  def follower
    foundUser = User.all.find do |user|
      user.id == object.object.follower_id
    end
    foundUser.slice(:name, :email)
  end

  def followee
    foundUser = User.all.find do |user|
      user.id == object.object.followee_id
    end
    foundUser.slice(:name, :email)
  end

end
