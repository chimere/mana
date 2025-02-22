class PlayersController < ApplicationController

  before_filter :find_game
  before_filter :redirect_if_player_exists

  def new
    @player = @game.players.new(user: current_user)
  end

  def create
    attrs = params[:player]
    attrs.merge!(:user => current_user) if current_user

    if @player = @game.players.create!(attrs)
      set_player_for( @game, @player.id)
      redirect_to @game
    else
      render :new
    end
  end

  def destroy
    # TODO
  end

  protected

  def redirect_if_player_exists
    redirect_to @game if is_playing?(@game)
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end
