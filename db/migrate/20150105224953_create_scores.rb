class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to :game
      t.belongs_to :user
      t.string :value, :default => 0
      t.integer :game_num, :null => :false
      t.timestamps
    end
  end
end
