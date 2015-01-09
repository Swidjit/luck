namespace :stats do
  desc "find user statistical scores"
  task :calculate_game_averages => :environment do
    @games = Game.all
    @games.each do |game|
      @avg = GameStat.where(:game_id => game.id).average(:avg)
      game.avg = @avg

    end
  end

  desc "calculate user overall scores"
  task :calculate_user_averages => :environment do
    @users = User.all
    @users.each do |user|
      user.score = Ranking.where(:user => user).average(:score)
      user.percentile = Ranking.where(:user => user).average(:percentile)
      user.save
    end
  end

  desc "do stat analysis"
  task :analyze => :environment do
    require 'descriptive_statistics'
    Ranking.delete_all
    data = GameStat.all.collect(&:avg)
    dev = data.standard_deviation
    @games = Game.all
    @games.each do |game|
      User.all.each do |user|
        stat = GameStat.where(:game_id => game.id, :user_id => user.id).first
        if stat.present?
          score_diff = stat.avg - data.mean
          num_devs = score_diff/dev.to_f
          stat_score = 500 + (100*num_devs)
          percentile = data.percentile_rank(stat.avg)
          @rank = Ranking.new(:user_id=> user.id, :game_id => game.id, :score => stat_score.round(2), :percentile => percentile.round(2))
          @rank.save
        end
      end
    end


  end
end