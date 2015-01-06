class AddAvgToGames < ActiveRecord::Migration
  def change
    add_column :games, :avg, :float
    add_column :games, :plays, :integer, :default => 0
    remove_column :games, :game_count
  end
end
