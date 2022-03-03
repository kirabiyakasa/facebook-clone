class AddIndexToComments < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :created_at
  end
end
