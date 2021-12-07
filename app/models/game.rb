class Game < ActiveRecord::Base
  attr_accessible :player_id, :player_ip, :puzzle_id, :start, :playtime, :solved, :revealed, :mistakes, :hints
end
