class Sell < ActiveRecord::Base
  belongs_to \
    :seller,
    class_name: 'User',
    foreign_key: 'seller_id'

  belongs_to :player

  before_create :create_transaction, if: :buyer_waiting?

  validates :player, presence: true
  validates :price, presence: true
  validates :seller, presence: true
  validates :shares, presence: true

  def buyer_waiting?
    Buy.find_by(player_id: player_id).present?
  end

  def create_transaction
    buy = Buy.pair_with_a_sell(player_id, price)
    if buy
      transaction = Transaction.new(
        buyer_id: buy.buyer_id,
        seller_id: seller_id,
        player_id: player_id,
        price: price,
        shares: buy.shares
      )
      transaction.save ? transaction : errors.add(:price, 'Error saving.')
    end
  end

  def self.pair_with_a_buy(player_id, buy_price)
    sells = Sell.where(player_id: player_id).order('price ASC, updated_at ASC')
    sells.where("price <= ?", buy_price).first
  end

  def price_in_dollars
    "$#{'%.2f' % (price / 100.0)}"
  end
end
