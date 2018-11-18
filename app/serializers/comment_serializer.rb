class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user
  belongs_to :post

  def user
    @comment_user = object.user
    { id: @comment_user.id, name: @comment_user.name, email: @comment_user.email }
  end
  #
  # def user
  #   if object.class != Comment
  #     foundUser = User.all.find do |user|
  #       user.id == object.object.user_id
  #     end
  #   else
  #     foundUser = User.all.find do |user|
  #       user.id == object.user_id
  #     end
  #   end
  #
  #   foundUser.slice(:name, :email)
  # end
  #
  # def post
  #   if object.class != Comment
  #     foundPost = Post.all.find do |post|
  #       post.id == object.object.post_id
  #     end
  #   else
  #     foundPost = Post.all.find do |post|
  #       post.id == object.post_id
  #     end
  #   end
  #
  #   {
  #     id: foundPost.id,
  #     user: foundPost.user.slice(:name, :email),
  #     content: foundPost.content
  #   }
  # end
end
