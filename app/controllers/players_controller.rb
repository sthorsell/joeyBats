class PlayersController < ApplicationController
  
  def index
    puts "ididid"
    puts params[:id]
    @p = nil
  end
  
  def create
    @player = Player.first
    puts "in new"
    puts params
    redirect_to :back
  end
  
  def save
    puts "abv"
    
    # p = Player.find(params[:player][:cafeID1])
    #     p.notes = params[:player][:notes]
    #     p.team_id = params[:player][:teamSelect]
    #     p.save
    if params[:player][:cafeID1]
      @id = params[:player][:cafeID1]
      Player.find(@id).update_attribute(:notes, params[:player][:notes])
      Player.find(@id).update_attribute(:team_id, params[:player][:teamSelect])
      Player.find(@id).update_attribute(:sbcValue, params[:player][:sbcValue])
      Player.find(@id).update_attribute(:tp, params[:player][:teamPos])
    elsif params[:player][:pcafeID1]
      @id = params[:player][:pcafeID1]
      Player.find(@id).update_attribute(:notes, params[:player][:pnotes])
      Player.find(@id).update_attribute(:team_id, params[:player][:pteamSelect])
      Player.find(@id).update_attribute(:sbcValue, params[:player][:psbcValue])
      Player.find(@id).update_attribute(:tp, params[:player][:pteamPos])
    end
    
    
    @actual = Team.all
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

    oldPts = Team.find_by_id(Player.find(@id).team_id).sbcScore
    
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
				@newPts = t.sbcScore
				t.save
		end
		@result = 'neutral'
		session[:res] = 'neutral'
		  
		if @newPts != nil and oldPts != nil
  		if oldPts > @newPts
  		  session[:res] = "bad"
  	  elsif @newPts > oldPts
  	    session[:res] = "good"
	    else
	      session[:res] = 'neutral'
      end
    
    
  end
		
    puts "SAVE"
    puts params[:player]
    puts params
    
    puts "OLDID"
    puts Player.find(@id).team_id
    redirect_to :back
  end
  
  def update
    
    puts "updating2"
    @pl = Player.first
    redirect_to post
  end
  
  def show
    puts params
    puts "inSHOW1"
    @pl = Player.find(params[:id])
    puts @pl.id
    
    respond_to do |format|
      
        format.json { render :json => @pl }
        format.js { render :layout => false }
      end
  end
  
end
