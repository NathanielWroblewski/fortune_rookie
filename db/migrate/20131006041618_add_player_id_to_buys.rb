class AddPlayerIdToBuys < ActiveRecord::Migration
  def change
    add_column :buys, :player_id, :integer, null: false
  end
end
