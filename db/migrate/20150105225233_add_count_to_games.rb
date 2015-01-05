class AddCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_count, :integer, :default => 0
  end
end
