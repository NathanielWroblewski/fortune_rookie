class BuysController < ApplicationController

  def new
    @player = Player.find_by(id: params[:id])
    not_found unless @player
    @buy = Buy.new
  end

  def create
    integerize(params[:buy][:price])
    @buy = Buy.new(buy_params)

    if @buy.save
      redirect_to players_path
    else
      render :new, flash: 'Error making purchase.'
    end
  end

  private

  def buy_params
    params.require(:buy).permit(:player_id, :shares, :price, :buyer_id, :role)
  end
end
