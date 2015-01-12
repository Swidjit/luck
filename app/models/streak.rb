class Streak < ActiveRecord::Base
  # attr_accessible :title, :description, :logo_url, :board_count, :rating, :times_played
  belongs_to :game
  belongs_to :user

  # validates :value, :uniqueness => {:scope => [:user, :game, :game_num]}
  # acts_as_commentable

end
