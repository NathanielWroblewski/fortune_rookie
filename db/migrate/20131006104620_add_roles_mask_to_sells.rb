class AddRolesMaskToSells < ActiveRecord::Migration
  def change
    add_column :sells, :role, :string
  end
end
