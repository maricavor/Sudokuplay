class SiteController < ApplicationController
	def index
		@title = "Sudokuplay - Free Online Sudoku Puzzle Generator!"
		if params[:id]
			@puzzle_id = params[:id].to_i
		else
			@puzzle_id = -1
		end
	end
  
  def about
  	@title = "Sudokuplay - About"
  end
end
