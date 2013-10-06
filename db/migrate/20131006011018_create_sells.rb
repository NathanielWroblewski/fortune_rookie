class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.integer :seller_id, null: false
      t.integer :price, default: 0, null: false
      t.integer :shares, default: 1, null: false
      t.timestamps
    end
  end
end
