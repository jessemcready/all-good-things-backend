class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at, :admin, :profile_url, :followers, :followees, :posts
  # has_many :posts, each_serializer: PostSerializer
  has_many :likes

  def followers
    Relationship.where(follower_id: object.id).map do |relationship|
      user = relationship.followee
      { id: user.id, name: user.name, email: user.email, profile_url: user.profile_url }
    end
  end

  def posts
    object.posts.map do |post|
      comments = format_comments(post)
      {
        id: post.id,
        content: post.content,
        flagged: post.flagged,
        created_at: post.created_at,
        user_id: post.user_id,
        comments: comments
      }
    end
  end

  def format_comments(post)
    post.comments.map do |comment|
      { id: comment.id, created_at: comment.created_at, content: comment.content, name: comment.user.name }
    end
  end

end
