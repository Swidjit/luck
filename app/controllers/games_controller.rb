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
      @game_stat = GameStat.where(:game_id => @score.game.id, :user_id => current_user.id).first
      if @game_stat.present?
        new_score = @game_stat.total + @score.value
        play_count = @game_stat.plays + 1
        new_avg = new_score/play_count.to_f
        @game_stat.assign_attributes(:total=> new_score, :plays => play_count, :avg => new_avg)
      else
        @game_stat = GameStat.new(:total=> @score.value, :plays => 1, :avg => @score.value, :user_id => @score.user.id, :game_id => @score.game.id)
      end
      @game_stat.save

      respond_with @game
    end
  end

  def load_resource_from_id
    @game = Game.find(params[:id])
  end
end
