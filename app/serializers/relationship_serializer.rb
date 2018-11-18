class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  belongs_to :follower
  belongs_to :followee

end
