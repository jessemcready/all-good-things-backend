class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :content, length: { in: 3..150, too_short: "%{count} characters minimum.", too_long: "%{count} characters is the max." }

end
