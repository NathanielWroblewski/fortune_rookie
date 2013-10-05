class Transaction < ActiveRecord::Base
  belongs_to \
    :buyer,
    class_name: 'User',
    foreign_key: 'buyer_id'

  belongs_to \
    :seller,
    class_name: 'User',
    foreign_key: 'seller_id'

  validates :buyer, presence: true
  validates :seller, presence: true
  validates :price, presence: true
  validates :shares, presence: true

  def price_in_dollars
    "$#{'%.2f' % (price / 100.0)}"
  end
end
