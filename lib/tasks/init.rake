namespace :init do

  task :games => :environment do
    Game.delete_all
    @game = Game.new(:title => "Lottery",:description => "Choose 5 numbers for your lottery ticket.  Score points depending on how many matches you make.", :expected_score => 1.033, :avg => 0, :plays=>0, :logo_url => "dummy.png")
    @game.save
    @game = Game.new(:title => "Next in Line",:description => "Wait until the perfect moment to take your place in line and get a score based on your position", :expected_score => 3, :avg => 0, :plays=>0, :logo_url => "spot-in-time.png")
    @game.save
    @game = Game.new(:title => "Card Flip",:description => "Choose 3 cards to flip over to reveal their point values (1-20).  Your score is the sum of the 3 cards.", :expected_score => 30, :avg => 0, :plays=>0, :logo_url => "card-flip.png")
    @game.save
    @game = Game.new(:title => "Press On",:description => "Press your luck on and on until you land on the wrong square.", :expected_score => 35, :avg => 0, :plays=>0, :logo_url => "dummy.png")
    @game.save
  end
end