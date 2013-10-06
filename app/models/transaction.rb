class Transaction < ActiveRecord::Base
  belongs_to \
    :buyer,
    class_name: 'User',
    foreign_key: 'buyer_id'

  belongs_to \
    :seller,
    class_name: 'User',
    foreign_key: 'seller_id'

  belongs_to :player

  after_create :create_holding
  after_create :update_player
  after_create :vanquish_holding

  validates :buyer, presence: true
  validates :player, presence: true
  validates :price, presence: true
  validates :seller, presence: true
  validates :shares, presence: true

  def create_holding
    p '*' * 10_000
    p buyer_id
    Holding.create(
      user_id: buyer_id,
      shares: shares,
      player_id: player_id,
      price_per_share: price,
    )
  end

  def price_in_dollars
    "$#{'%.2f' % (price / 100.0)}"
  end

  def update_player
    player = Player.find_by(id: player_id)
    player.update_attributes(current_price: price)
  end

  def vanquish_holding
    holding = Holding.find_by(
      user_id: seller_id,
      shares: shares,
      player_id: player_id
    )
    holding.try(:destroy)
  end
end
