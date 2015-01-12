class Score < ActiveRecord::Base
  # attr_accessible :title, :description, :logo_url, :board_count, :rating, :times_played
  belongs_to :game
  belongs_to :user

  # validates :value, :uniqueness => {:scope => [:user, :game, :game_num]}
  # acts_as_commentable
  after_save :update_streaks

  def update_streaks
    if self.value > 0
      streak = self.user.streaks.where(:game_id => self.game.id).first
      if streak.present?
        if self.value > self.game.expected_score
          streak.direction == "good" ? streak.increment(:streak) : streak.update_attributes(:streak => 1, :direction => "good")
        elsif self.value < self.game.expected_score
          streak.direction == "bad" ? streak.increment(:streak) : streak.update_attributes(:streak => 1, :direction => "bad")
        end
      else
        if self.value > self.game.expected_score
          streak = Streak.new(:game=>self.game,:user=>self.user,:direction=>"good",:streak=>1)
        elsif self.value < self.game.expected_score
          streak = Streak.new(:game=>self.game,:user=>self.user,:direction=>"bad",:streak=>1)
        end

      end
      streak.save

      # updating overall streaks
      streak = self.user.streaks.where(:game_id => 0).first
      if streak.present?
        if self.value > self.game.expected_score
          streak.direction == "good" ? streak.increment(:streak) : streak.update_attributes(:streak => 1, :direction => "good")
        elsif self.value < self.game.expected_score
          streak.direction == "bad" ? streak.increment(:streak) : streak.update_attributes(:streak => 1, :direction => "bad")
        end
      else
        if self.value > self.game.expected_score
          streak = Streak.new(:game_id => 0,:user=>self.user,:direction=>"good",:streak=>1)
        elsif self.value < self.game.expected_score
          streak = Streak.new(:game_id => 0,:user=>self.user,:direction=>"bad",:streak=>1)
        end

      end
      streak.save
    end
  end

end
