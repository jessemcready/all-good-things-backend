class Post < ApplicationRecord

  has_many :comments
  has_many :likes
  belongs_to :user

  validates :content, length: { in: 5..400 }

end
