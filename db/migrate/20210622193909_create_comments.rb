class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
