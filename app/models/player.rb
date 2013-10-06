class Player < ActiveRecord::Base

  before_create :set_current_price
  after_create :create_sell

  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :draft_year,    presence: true
  validates :ipo,           presence: true
  validates :current_price, presence: true
  validates :last_ask,      presence: true

  def ipo_in_dollars
    "$#{'%.2f' % (ipo / 100.0)}"
  end

  def set_current_price
    self.current_price = ipo
  end

  def create_sell
    Sell.create(player_id: id, seller_id: 1, price: ipo, shares: 100)
  end
end
