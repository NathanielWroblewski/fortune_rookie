class ServicesController < ApplicationController
  def player_stats
    transactions = Transaction.where(player_id: params[:id])
    transactions = transactions.order('updated_at ASC')
    prices = transactions.map(&:price)
    times = transactions.map(&:updated_at)
    data_points = times.zip(prices)

    render json: { dataPoints: data_points }
  end
end
