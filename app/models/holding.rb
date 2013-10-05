class Holding < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :shares, presence: true
  validates :price_per_share, presence: true

  def cash_per_share
    "$#{'%.2f' % (price_per_share / 100.0)}"
  end
end
