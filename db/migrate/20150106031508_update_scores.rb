class UpdateScores < ActiveRecord::Migration
  def change
    remove_column :scores, :value
    add_column :scores, :value, :integer, :default => 0
  end
end
