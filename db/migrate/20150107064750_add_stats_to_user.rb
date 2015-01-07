class AddStatsToUser < ActiveRecord::Migration
  def change
    add_column :users, :score, :float, :default => 0
    add_column :users, :percentile, :float, :default => 0
  end
end
