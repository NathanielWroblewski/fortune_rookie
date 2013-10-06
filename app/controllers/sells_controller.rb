class SellsController < ApplicationController

  def new
    @player = Player.find_by(id: params[:id])
    not_found unless @player
    @sell = Sell.new
  end

  def create
    @sell = Sell.new(sell_params)

    if @sell.save
      redirect_to players_path
    else
      render :new, flash: 'Error making purchase.'
    end
  end

  def sell_params
    params.require(:sell).permit(:price, :shares, :player_id, :seller_id)
  end
end
