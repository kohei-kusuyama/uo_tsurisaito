class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :follower_id,     null: false #フォロワー
      t.integer :followed_id,     null: false #フォロー

      t.timestamps
    end
  end
end
