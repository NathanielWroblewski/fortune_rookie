class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :buyer_id, null: false
      t.integer :seller_id, null: false
      t.integer :price, default: 0, null: false
      t.integer :shares, default: 0, null: false
      t.timestamps
    end
  end
end
