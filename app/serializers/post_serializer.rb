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

end
