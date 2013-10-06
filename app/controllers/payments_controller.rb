class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
  end

  def create
    result = Braintree::Transaction.sale(
      amount: params[:amount],
      credit_card: {
        number: params[:credit_card][:number],
        expiration_month: params[:month],
        expiration_year: params[:year]
      },
      options: {
        submit_for_settlement: true
      }
    )
    if result.success?
      current_user.braintree_payment(integerize(params[:amount]))
      redirect_to root_path, notice: 'Success.'
    else
      render :new, notice: 'Error.'
    end
  end
end
