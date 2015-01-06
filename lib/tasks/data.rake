namespace :data do

  desc "check to see if spot in time needs more values"
  task :check_spot_in_time => :environment do
    count = SpotValue.all.count
    if count < 500
      addValues
    end
  end

  def addValues
    values = (1..500).to_a.shuffle
    values.each do |v|
      SpotValue.create(:value=>v)
    end
  end
end