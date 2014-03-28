class TaxiController < ApplicationController
	def index
	    @currentTeam = Team.first.id
	    @currentPos = 'All'
	    @currentSort = 'espnValue'
	    puts "curteam"
	    puts @currentTeam
	    @players = Player.find_all_by_team_id(@currentTeam)
	    
	    @teams = Team.where(year_id:2)
	    @players.sort! {|b,a| a.espnValue <=> b.espnValue}
	end

end
