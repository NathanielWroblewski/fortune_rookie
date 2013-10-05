class UsersController < ApplicationController

  def show
    @buys = Transaction.where(buyer_id: current_user.id).limit(5)
    @sales = Transaction.where(seller_id: current_user.id).limit(5)
  end
end
