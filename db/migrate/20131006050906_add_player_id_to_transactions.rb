class AddPlayerIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :player_id, :integer, null: false
  end
end
