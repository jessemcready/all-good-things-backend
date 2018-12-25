class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :flagged, :created_at, :updated_at, :user, :likes, :comments

  def comments
    sorted_comments = object.comments.sort do |x, y|
      y.id <=> x.id
    end
    sorted_comments.map do |comment|
      @comment_user = comment.user
      { id: @comment_user.id, profile_url: @comment_user.profile_url, email: @comment_user.email, name: @comment_user.name, content: comment.content, created_at: comment.created_at }
    end
  end

  def likes
    object.likes.map do |like|
      @like_user = like.user
      { id: @like_user.id, email: @like_user.email, name: @like_user.name }
    end
  end

end
