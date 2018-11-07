class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :comments, :likes, :user, :created_at, :updated_at

  def user
    foundUser = User.all.find do |user|
      user.id == object.user_id
    end
    foundUser.slice(:name, :email)
  end

  def likes
    likes = Like.where(post_id: object.id)
    likes.map do |like|
      {
        id: like.id,
        user: like.user.slice(:name, :email)
      }
    end
  end

  def comments
    comments = Comment.where(post_id: object.id).order(id: :desc)
    comments.map do |comment|
      CommentSerializer.new(comment)
    end
  end

end
