class AddCurrentPriceAndLastAskPlayersTable < ActiveRecord::Migration
  def up
    add_column :players, :current_price, :integer, default: 0
    add_column :players, :last_ask, :integer, default: 0
  end

  def down
    remove_column :players, :current_price
    remove_column :players, :last_ask
  end
end
