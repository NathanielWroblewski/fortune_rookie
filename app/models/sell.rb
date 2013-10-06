class Sell < ActiveRecord::Base
  belongs_to \
    :seller,
    class_name: 'User',
    foreign_key: 'seller_id'

  belongs_to :player

  validates :player, presence: true
  validates :price, presence: true
  validates :seller, presence: true
  validates :shares, presence: true

  def self.pair_with_a_buy(player_id, buy_price)
    sells = Sell.where(player_id: player_id).order('price ASC, updated_at ASC')
    sells.where("price <= ?", buy_price).first
  end

  def price_in_dollars
    "$#{'%.2f' % (price / 100.0)}"
  end
end
