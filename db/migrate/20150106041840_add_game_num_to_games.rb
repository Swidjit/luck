class AddGameNumToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_num, :integer, :default => 1
  end
end
