class CreateSpotValues < ActiveRecord::Migration
  def change
    create_table :spot_values do |t|
      t.integer :value
    end
  end
end
