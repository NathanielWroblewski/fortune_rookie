class PlayersController < ApplicationController

  def index
    @players = Player.where(draft_year: Time.now.year)
  end

  def show
    @player = Player.find_by(id: params[:id])
    @players = Player.where(position: @player.position)
    @players.reject!{|player| player.id == @player.id}
  end

end


