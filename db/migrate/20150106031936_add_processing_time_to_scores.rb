class AddProcessingTimeToScores < ActiveRecord::Migration
  def change
    add_column :scores, :process_time, :datetime
  end
end
