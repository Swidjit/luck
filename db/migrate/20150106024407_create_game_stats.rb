class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats do |t|
      t.float :avg
      t.integer :total
      t.integer :plays
      t.belongs_to :user
      t.belongs_to :game

    end
  end
end
