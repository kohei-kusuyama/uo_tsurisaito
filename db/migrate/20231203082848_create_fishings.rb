class CreateFishings < ActiveRecord::Migration[6.1]
  def change
    create_table :fishings do |t|
      
      t.integer :post_id,       null: false, default: ""
      t.string :type,           null: false, default: ""
      t.string :point,          null: false, default: ""
      t.string :size,           null: false, default: ""

      t.timestamps
    end
  end
end
