class AddSessionIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :session_id, :integer
  end
end
