namespace :data do

  desc "check to see if spot in time needs more values"
  task :check_spot_in_time => :environment do
    count = SpotValue.all.count
    if count < 5
      addValues
    end
  end

  task :estimate_avg => :environment do
    total_count = 0
    for i in 1..1000000
      guesses= []
      answers= []

      for i in 1..5
        guesses << Random.rand(20)
      end
      for i in 1..5
        answers << Random.rand(20)
      end

      count = 0
      answers.each do |a|
        if guesses.include?(a)
          count = count+1
          guesses.delete_at(guesses.index(a) || guesses.length)
        end
      end
      total_count = total_count +  count

    end
    puts (total_count.to_f/1000000)
  end

  def addValues
    user_count = User.all.count
    values = (1..user_count).to_a.shuffle
    values.each do |v|
      SpotValue.create(:value=>v)
    end
    game = Game.find(3)
    game.expected_score = user_count.to_f/2
    game.save
  end


end