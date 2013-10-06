class AddPlayerIdToSells < ActiveRecord::Migration
  def change
    add_column :sells, :player_id, :integer, null: false
  end
end
