class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :body
      t.references :comment, foreign_key: true

      t.timestamps null: false
    end
  end
end
