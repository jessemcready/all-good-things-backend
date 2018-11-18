class LikeSerializer < ActiveModel::Serializer

  attributes :id
  belongs_to :post

  def user
    @like_user = object.user
    { id: @like_user.id, name: @like_user.name, email: @like_user.email }
  end 

end
