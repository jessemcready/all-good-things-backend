class Relationship < ApplicationRecord

  belongs_to :follower, :class_name => "User", dependent: :destroy
  belongs_to :followee, :class_name => "User", dependent: :destroy

end
