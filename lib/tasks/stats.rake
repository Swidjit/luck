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
end