class LikeSerializer < ActiveModel::Serializer

  attributes :id
  belongs_to :user
  belongs_to :post

  # def user
  #   foundUser = User.all.find do |user|
  #     user.id == object.object.user_id
  #   end
  #   foundUser.slice(:name, :email)
  # end
  #
  # def post
  #   foundPost = Post.all.find do |post|
  #     post.id == object.object.post_id
  #   end
  #   {
  #     id: foundPost.id,
  #     user: foundPost.user.slice(:name, :email),
  #     content: foundPost.content
  #   }
  # end

end
