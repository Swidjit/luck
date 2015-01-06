namespace :stats do
  desc "find user statistical scores"
  task :calculate_game_averages => :environment do
    @games = Game.all
    @games.each do |game|
      @avg = GameStat.where(:game_id => game.id).average(:avg)
      puts @avg
      game.avg = @avg
      game.increment!(:plays)
    end
  end

  desc "do stat analysis"
  task :analyze => :environment do
    require 'descriptive_statistics'
    Ranking.delete_all
    data = GameStat.all.collect(&:avg)
    dev = data.standard_deviation
    User.all.each do |user|
      stat = GameStat.where(:game_id => 1, :user_id => user.id).first
      score_diff = stat.avg - data.mean
      num_devs = score_diff/dev.to_f
      stat_score = 500 + (100*num_devs)
      percentile = data.percentile_rank(stat.avg)
      @rank = Ranking.new(:user_id=> user.id, :game_id => 1, :score => stat_score.round(2), :percentile => percentile.round(2))
      @rank.save
    end


  end
end