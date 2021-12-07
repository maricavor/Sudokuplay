class SudokuController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def generate
  	if !params[:puzzle_id] && params[:lvl] 
      level = params[:lvl].to_i
      file = "public/puzzles/level"+level.to_s+".log"
      size = IO.readlines(file).size
      line = rand(size)+1
      count = 0
      puzzle = ""
      File.new(file).each do |l|
        count+ = 1
        if count == line
          puzzle = l
          break
        end
      end
      render :text => 'id=' + level.to_s + count.to_s + '&puzzle=' + puzzle
    else
      id = params[:puzzle_id].to_s
      level = id[0].chr.to_i
      file = "public/puzzles/level" + level.to_s + ".log"
      size = IO.readlines(file).size
      line = id[1,id.length].to_i
      count = 0
      puzzle = ""
      File.new(file).each do |l|
        count += 1
        if count == line
          puzzle = l
          break
        end
      end
      render :text => 'id=' + level.to_s + count.to_s + '&puzzle=' + puzzle
    end
  end

  def save
    game = Game.new(:puzzle_id => params[:puzzle_id],:start => params[:start_time].to_datetime,
    :player_ip => request.remote_ip.to_s) 
    if not session[:player_id].nil?
      game.player_id=Player.find(session[:player_id]).id
    end
    game.save
    render :nothing => true
  end

  def update
    ip=request.remote_ip.to_s
    game=Game.find_by_start_and_player_ip(params[:start_time].to_datetime,ip)
    if game
      game.update_attribute :revealed, params[:revealed]
      game.update_attribute :playtime, params[:play_time].to_i
      game.update_attribute :solved, params[:solved]
      game.update_attribute :mistakes, params[:mistakes]
      game.update_attribute :hints, params[:hints]
    end
    if params[:solved]==true && params[:hints].to_i==0
      id=game.puzzle_id.to_s
      time=convert(game.playtime)
      level = case id[0].chr.to_i
        when 1 then "Easy"
        when 2 then "Medium"
        when 3 then "Difficult"
        when 4 then "Extreme"
      end
      status=level+" sudoku puzzle solved in "+time+": http://www.sudokuplay.net/puzzle/"+id
      client = Twitter::Client.new(:login => 'sudokuplay', :password => 'phoenix27')
      new_message = client.status(:post, status)
    end
    render :nothing => true
  end

  private

  def convert(ms)
    hours = (ms / 3600000).to_i
    minutes = (ms / 60000).to_i - (hours*60)
      seconds = (ms /1000).to_i - (hours*3600) - (minutes*60)
    ret = ""
    ret = ret + hours.to_s + "h " if hours >= 1
    ret = ret + minutes.to_s + "m " if minutes >= 1 
    ret = ret + seconds.to_s + "s " if seconds > 0 
    return ret
  end
end
