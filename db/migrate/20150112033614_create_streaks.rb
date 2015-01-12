class CreateStreaks < ActiveRecord::Migration
  def change
    create_table :streaks do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.integer :streak, :default => 0
      t.string :direction
    end
  end
end
