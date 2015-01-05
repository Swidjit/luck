class GamesController < ApplicationController
  respond_to :html
  before_filter :load_resource_from_id, :except => []
  def show

    # @comments = @game.comment_threads.order('created_at desc')
    # @new_comment = Comment.build_from(@game, current_user.id, "") if user_signed_in?
  end

  def save_score
    @score = params[:score]
    @score = Score.new(:game=>@game, :user=>current_user, :value=>params[:score],:game_num => @game.game_count)
    if @score.save!
      respond_with @game
    end
  end

  def load_resource_from_id
    @game = Game.find(params[:id])
  end
end
