class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id,   null: false
      t.text :content,      null: false
      t.string :title,      null: false, default: ""
      t.string :category,   null: false, default: ""
      t.string :point,      null: false, default: ""
      t.string :size,       null: false, default: ""

      t.timestamps
    end
  end
end
