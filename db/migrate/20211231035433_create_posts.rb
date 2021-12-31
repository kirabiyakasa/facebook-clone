class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :body
      t.number :likes
      t.number :dislikes
    end
  end
end
