class GamesController < ApplicationController
  respond_to :html
  before_filter :load_resource_from_id, :except => [:index, :spot_value]
  def show
    @user_ranking = Ranking.where(:game_id => params[:id], :user_id => current_user.id).first if user_signed_in?
    @best = Ranking.where(:game_id => params[:id]).order(score: :desc).limit(10)
    @worst = Ranking.where(:game_id => params[:id]).order(:score).limit(10)
    # @comments = @game.comment_threads.order('created_at desc')
    # @new_comment = Comment.build_from(@game, current_user.id, "") if user_signed_in?

    # for card flip game
    @values = (1..20).to_a.shuffle
  end

  def index
    @games = Game.all
  end

  def save_score
    @score = params[:score]
    @score = Score.new(:game=>@game, :user=>current_user, :value=>params[:score],:game_num => @game.game_num)
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

      respond_to do |format|
        format.js {render 'score_saved'}
      end
    end
  end

  def spot_value
    @spot = SpotValue.first
    @score = @spot.value
    @spot.destroy
    respond_to do |format|
      format.js {render 'spot_value'}
    end
  end

  def load_resource_from_id
    @game = Game.find(params[:id])
  end
end
