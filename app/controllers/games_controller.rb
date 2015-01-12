class GamesController < ApplicationController
  respond_to :html
  before_filter :load_resource_from_id, :except => [:index, :spot_value]
  require 'action_view'

  include ActionView::Helpers::DateHelper
  def show
    @user_ranking = Ranking.where(:game_id => params[:id], :user_id => current_user.id).first if user_signed_in?
    @best = Ranking.where(:game_id => params[:id]).order(score: :desc).limit(10)
    @worst = Ranking.where(:game_id => params[:id]).order(:score).limit(10)
    @streaks = @game.streaks.where(:direction=>"good").order(streak: :desc).limit(10)
    @comments = @game.comment_threads.order('created_at desc')
    if user_signed_in?
      @new_comment = Comment.build_from(@game, current_user.id, "")

      #get all games user is eligible to play
      @eligible_games = [1,2,3]
      @eligibility_times = []
      for i in 1..3
        s = current_user.scores.where('game_id=? and created_at >= ?',i, 1.seconds.ago).first
        if s.present?
          @eligible_games.delete(i)
          @eligibility_times[i] = s.created_at + 3.hours
        end
      end
    end
    # for card flip game
    @values = (1..20).to_a.shuffle

  end

  def index
    @games = Game.all
  end

  def init_score
    @score = Score.new(:game=>@game, :user=>current_user, :value=>-1)
    @score.save
    @score.value = -1
    if @score.save
       respond_to do |format|
        format.js {render 'init_score'}
      end
    end
  end

  def save_score
    @score = Score.where(:game=>@game, :user=>current_user, :value=>-1).last

    @score.value = params[:score]
    if @score.save!
      @game.increment!(:plays)
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


    end
  end

  def spot_value
    @spot = SpotValue.first
    @s = @spot.value
    @score = Score.new(:game_id=>3, :user=>current_user, :value=>@s)
    @spot.destroy
    if @score.save!
      @game=Game.find(3)
      @game.increment!(:plays)
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
        format.js {render 'spot_value'}
      end
    end
  end

  def game_averages

  end

  def load_resource_from_id
    @game = Game.find(params[:id])
  end
end
