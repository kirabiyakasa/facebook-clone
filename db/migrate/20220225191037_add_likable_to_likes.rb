class AddLikableToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :likable, polymorphic: true, null: false
  end
end
