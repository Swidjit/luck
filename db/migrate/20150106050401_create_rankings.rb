class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :game_id
      t.integer :user_id
      t.float :score
      t.float :percentile
    end
  end
end
