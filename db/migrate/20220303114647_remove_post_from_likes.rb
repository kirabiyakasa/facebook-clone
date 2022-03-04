class RemovePostFromLikes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :likes, :post, null: false, foreign_key: true
  end
end
