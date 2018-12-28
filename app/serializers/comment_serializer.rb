class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :post

  def user
    @comment_user = object.user
    { id: @comment_user.id, name: @comment_user.name, email: @comment_user.email, profile_url: @comment_user.profile_url }
  end

end
