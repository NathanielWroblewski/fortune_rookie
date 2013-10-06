class UsersController < ApplicationController
  # include UserHelper

  def show
    @transactions = Transaction.where("buyer_id = ? or seller_id = ?", current_user.id, current_user.id).limit(5)
  end
end
