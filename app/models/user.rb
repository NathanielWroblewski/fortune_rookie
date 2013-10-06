class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :holdings

  def balance_as_money
    "$#{'%.2f' % (balance / 100.0)}"
  end

  def braintree_payment(amount)
    update_attributes(balance: balance + amount)
  end

end
