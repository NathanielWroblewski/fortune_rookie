class Player < ActiveRecord::Base

  before_create :set_current_price
  before_create :set_ask_price
  after_create :create_sell

  validates :first_name,    presence: true
  validates :last_name,     presence: true
  validates :draft_year,    presence: true
  validates :ipo,           presence: true
  validates :current_price, presence: true
  validates :last_ask,      presence: true

  def current_price_in_dollars
    "$#{'%.2f' % (current_price / 100.0)}"
  end

  def ask_price_in_dollars
    "$#{'%.2f' % (last_ask / 100.0)}"
  end

  def set_current_price
    self.current_price = ipo
  end

  def set_ask_price
    self.last_ask = 0
  end

  def create_sell
    admin = User.find_by(email: 'admin@admin.com')
    Sell.create(player_id: id, seller_id: admin.id, price: ipo, shares: 1, role: 'pending')
    admin.holdings << Holding.create(player_id: id, user_id: admin.id, price_per_share: ipo, shares: 1)
  end
end
