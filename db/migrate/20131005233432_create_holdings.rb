class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.references :user, null: false
      t.integer :shares, default: 1, null: false
      t.integer :price_per_share, default: 0, null: false
    end
  end
end
