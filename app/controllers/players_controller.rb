class PlayersController < ApplicationController

  def index
    @players = Player.where(draft_year: Time.now.year)
  end

  def show
    
  end

end
