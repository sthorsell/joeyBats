class StandingsController < ApplicationController
	def index
		    @actual = Team.where(year_id:2)
  			@actual.shift
	  		k = @actual.sort {|a,b| a.teamPk <=> b.teamPk}
	  		era = @actual.sort {|b,a| a.teamEra <=> b.teamEra}
	  		whip = @actual.sort {|b,a| a.teamWhip <=> b.teamWhip}
	  		w = @actual.sort {|a,b| a.teamW <=> b.teamW}
	  		sv = @actual.sort {|a,b| a.teamSv <=> b.teamSv}
	  		hr = @actual.sort {|a,b| a.teamHr <=> b.teamHr}
	  		rbi = @actual.sort {|a,b| a.teamRbi <=> b.teamRbi}
	  		r = @actual.sort {|a,b| a.teamR <=> b.teamR}
	  		avg = @actual.sort {|a,b| a.teamAvg <=> b.teamAvg}
	  		sb = @actual.sort {|a,b| a.teamSb <=> b.teamSb}
	      
	  		@actual.each_with_index do |t, i|
	  		    t.sbcScore = 0
	  		    
	  				t.sbcScore = t.sbcScore + 1 + era.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + k.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + whip.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + w.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + sv.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + avg.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + r.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + rbi.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + sb.index{ |item| item.teamName == t.teamName }
	  				t.sbcScore = t.sbcScore + 1 + hr.index{ |item| item.teamName == t.teamName }
	  				t.save
	  		end
	      
	end 
end
