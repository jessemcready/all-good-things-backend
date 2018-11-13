class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :posts, :likes, :comments, :followers, :followees, :created_at, :updated_at, :admin, :profile_url

  def commentFormat(comments)
    comments.map do |comment|
      CommentSerializer.new(comment)
    end
  end

  def posts
    if object.class != User
      object.object.posts.map do |post|
        PostSerializer.new(post)
      end
    else
      object.posts.map do |post|
        PostSerializer.new(post)
      end
    end
  end

  def followers
    if object.class != User
      relationships = Relationship.all.where(follower_id: object.object.id) do |user|
        user.id == object.object.user_id
      end
    else
      relationships = Relationship.all.where(follower_id: object.id) do |user|
        user.id == object.user_id
      end
    end
    relationships.map do |relationship|
      if relationship.followee
        posts = relationship.followee.posts.map do |post|
          user = User.find(post.user_id)
          {
            id: post.id,
            user: {
              id: user.id,
              name: user.name,
              email: user.email,
              profile_url: user.profile_url
            },
            content: post.content,
            comments: commentFormat(post.comments),
            likes: post.likes,
            flagged: post.flagged,
            created_at: post.created_at
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
  end

  def followees
    if object.class != User
      relationships = Relationship.all.where(followee_id: object.object.id) do |user|
        user.id == object.object.user_id
      end
    else
      relationships = Relationship.all.where(followee_id: object.id) do |user|
        user.id == object.user_id
      end
    end
    relationships.map do |relationship|
      posts = relationship.follower.posts.map do |post|
        user = User.find(post.user_id)
        {
          id: post.id,
          user: {
            id: post.user.id,
            name: post.user.name,
            email: post.user.email
          },
          content: post.content,
          comments: commentFormat(post.comments),
          likes: post.likes
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
