class PagesController < ApplicationController

  def home
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup' || action_name == 'sign_in' || action_name == 'sign_up'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user
      if current_user.username.include?('dummy-')
        redirect_to finish_signup_path(current_user)
      end
    end
    @todays_luckiest = []
    @game1_scores = Score.where('updated_at > ? and game_id=1', Time.now-24.years).order(value: :asc).take(3)
    @game2_scores = Score.where('updated_at > ? and game_id=2', Time.now-24.years).order(value: :asc).take(3)
    @game3_scores = Score.where('updated_at > ? and game_id=3', Time.now-24.years).order(value: :asc).take(3)
    @game4_scores = Score.where('updated_at > ? and game_id=4', Time.now-24.years).order(value: :asc).take(3)

    @todays_luckiest << @game1_scores[0].user if !@game1_scores[0].nil?
    @todays_luckiest << @game2_scores[0].user if !@game2_scores[0].nil?
    @todays_luckiest << @game3_scores[0].user if !@game3_scores[0].nil?
    @todays_luckiest << @game4_scores[0].user if !@game4_scores[0].nil?
    @todays_luckiest << @game1_scores[1].user if !@game1_scores[1].nil?
    @todays_luckiest << @game2_scores[1].user if !@game2_scores[1].nil?
    @todays_luckiest << @game3_scores[1].user if !@game3_scores[1].nil?
    @todays_luckiest << @game4_scores[1].user if !@game4_scores[1].nil?
    @todays_luckiest << @game1_scores[2].user if !@game1_scores[2].nil?
    @todays_luckiest << @game2_scores[2].user if !@game2_scores[2].nil?
    @todays_luckiest << @game3_scores[2].user if !@game3_scores[2].nil?
    @todays_luckiest << @game4_scores[2].user if !@game4_scores[2].nil?
  end

  def index
    @title = params[:page_name].titleize

    render params[:page_name]
  end
end
