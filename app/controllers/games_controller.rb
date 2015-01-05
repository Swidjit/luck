class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])

    # @comments = @game.comment_threads.order('created_at desc')
    # @new_comment = Comment.build_from(@game, current_user.id, "") if user_signed_in?
  end


end
