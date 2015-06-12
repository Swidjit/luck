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
        guesses << Random.rand(15)
      end
      for i in 1..5
        answers << Random.rand(15)
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

  task :set_expected_score_for_press_on => :environment do
    total_score = 0
    for i in 1..1000 do
      values = [0,0,0,1,1,1,5,5,5,10,10,10,25,25,25,50]
      score = 0
      val = -1
      while val != 0
        val = values.shuffle.pop
        values.push(0)
        score += val
        puts "#{val} - #{score}"
      end
      total_score += score
      puts "total score: #{total_score}"
    end
    avg_score = total_score/1000
    puts avg_score
  end

end