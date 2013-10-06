class AddPlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string   :first_name, null: false
      t.string   :last_name,  null: false
      t.integer  :draft_year, null: false
      t.integer  :ipo,        null: false, default: 0
      t.string   :position
      t.string   :height
      t.string   :weight
      t.string   :school

      t.timestamps
    end
  end
end
