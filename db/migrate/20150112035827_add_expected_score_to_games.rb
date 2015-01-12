class AddExpectedScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :expected_score, :float
  end
end
