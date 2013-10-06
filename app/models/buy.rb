class Buy < ActiveRecord::Base
  belongs_to \
    :buyer,
    class_name: 'User',
    foreign_key: 'buyer_id'
  belongs_to :player

  before_create :create_transaction, if: :seller_waiting?

  validates :buyer, presence: true
  validates :player, presence: true
  validates :price, presence: true
  validates :shares, presence: true

  def create_transaction
    sell = Sell.pair_with_a_buy(player_id, price)
    if sell
      transaction = Transaction.new(
        buyer_id: buyer_id,
        seller_id: sell.seller_id,
        player_id: player_id,
        price: sell.price,
        shares: shares
      )
      transaction.save ? transaction : errors.add(:price, 'Error saving.')
    end
  end

  def price_in_dollars
    "$#{'%.2f' % (price / 100.0)}"
  end

  def seller_waiting?
    Sell.find_by(player_id: player_id).present?
  end
end
