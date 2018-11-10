class AddFlaggedToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :flagged, :boolean, :default => false
  end
end
