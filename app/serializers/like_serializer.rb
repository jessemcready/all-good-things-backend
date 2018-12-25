class LikeSerializer < ActiveModel::Serializer
  attributes :id, :post, :user

  def user
    @like_user = object.user
    { id: @like_user.id, name: @like_user.name, email: @like_user.email }
  end

end
