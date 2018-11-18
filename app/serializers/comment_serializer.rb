class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user
  belongs_to :post

  def user
    @comment_user = object.user
    { id: @comment_user.id, name: @comment_user.name, email: @comment_user.email }
  end
  
end
