class Game < ActiveRecord::Base
  # attr_accessible :title, :description, :logo_url, :board_count, :rating, :times_played
  has_many :scores, :dependent => :delete_all
  has_many :streaks, :dependent => :delete_all


  acts_as_commentable

end
