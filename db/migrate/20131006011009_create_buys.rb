class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.integer :buyer_id, null: false
      t.integer :price, default: 0, null: false
      t.integer :shares, default: 1, null: false
      t.timestamps
    end
  end
end
