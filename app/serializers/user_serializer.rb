class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :posts, :likes, :comments, :followers, :followees, :created_at, :updated_at

  def commentFormat(comments)
    comments.map do |comment|
      CommentSerializer.new(comment)
    end
  end

  def posts
    object.posts.map do |post|
      PostSerializer.new(post)
    end
  end

  def followers
    relationships = Relationship.all.where(follower_id: object.object.id)
    relationships.map do |relationship|
      posts = relationship.followee.posts.map do |post|
        user = User.find(post.user_id)
        {
          id: post.id,
          user_id: user.id,
          username: user.name,
          content: post.content,
          comments: commentFormat(post.comments)
        }
      end
      {
        id: relationship.followee.id,
        name: relationship.followee.name,
        email: relationship.followee.email,
        posts: posts
      }
    end
  end

  def followees
    relationships = Relationship.all.where(followee_id: object.object.id)
    relationships.map do |relationship|
      posts = relationship.follower.posts.map do |post|
        user = User.find(post.user_id)
        {
          id: post.id,
          user: user.name,
          content: post.content,
          comments: commentFormat(post.comments)
        }
      end
      {
        id: relationship.follower.id,
        name: relationship.follower.name,
        email: relationship.follower.email,
        posts: posts
      }
    end
  end

end
