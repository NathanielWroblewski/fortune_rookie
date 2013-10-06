class Player < ActiveRecord::Base

  before_create :set_current_price

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
end
