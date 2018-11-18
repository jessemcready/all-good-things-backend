class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :flagged, :created_at, :updated_at
  belongs_to :user
  has_many :likes
  has_many :comments

  def comments
    object.comments.sort do |x, y|
      y.id <=> x.id
    end
  end

  # def user
  #   foundUser = User.all.find do |user|
  #     user.id == object.user_id
  #   end
  #   foundUser.slice(:id, :name, :email, :profile_url)
  # end
  #
  # def likes
  #   likes = Like.where(post_id: object.id)
  #   likes.map do |like|
  #     {
  #       id: like.id,
  #       user: like.user.slice(:name, :email)
  #     }
  #   end
  # end
  #
  # def comments
  #   comments = Comment.where(post_id: object.id).order(id: :desc)
  #   if object.class != Post
  #     comments << Comment.where(post_id: object.object.id).order(id: :desc)
  #   end
  #   comments.map do |comment|
  #     CommentSerializer.new(comment)
  #   end
  # end

end
