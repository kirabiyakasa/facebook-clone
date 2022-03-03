class AddIndexToPosts < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, :created_at
  end
end
