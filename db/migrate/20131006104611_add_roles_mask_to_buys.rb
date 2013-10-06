class AddRolesMaskToBuys < ActiveRecord::Migration
  def change
    add_column :buys, :role, :string
  end
end
