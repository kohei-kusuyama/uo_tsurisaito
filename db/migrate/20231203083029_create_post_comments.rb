class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.integer :post_id,     null: false, default: ""
      t.integer :user_id,     null: false, default: ""
      t.text :content,        null: false

      t.timestamps
    end
  end
end
