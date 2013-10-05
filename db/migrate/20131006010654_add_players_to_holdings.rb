class AddPlayersToHoldings < ActiveRecord::Migration
  def up
    add_column :holdings, :player_id, :integer, null: false
  end

  def down
    remove_column :holdings, :player_id
  end
end
