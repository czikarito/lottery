class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.boolean :bidding
      t.integer :user_id
      t.integer :item_id

      t.timestamps

    end
    add_index :bids, :user_id, unique: true
  end

end
