class HomeController < ApplicationController
  def index
    @currentTeam = Team.first.id
    @currentPos = 'All'
    @currentSort = 'espnValue'
    puts "curteam"
    puts @currentTeam
    @players = Player.find_all_by_team_id(@currentTeam)
    
    @teams = Team.where(year_id:2)
    @players.sort! {|b,a| a.espnValue <=> b.espnValue}
    puts params
    @result = session[:res]
		session[:res] = 'neutral'  
  end
  
  def changeTeam
    if params[:playerSelect]
      puts "inparams"
      @players = Player.find_all_by_team_id(params[:playerSelect])
      @currentTeam = params[:playerSelect] 
    end

    hittingCats = ['AVG', 'SB', 'RBI', 'HR', 'R']
    pitchingCats = ['ERA', 'WHIP', 'W', 'PK', 'SV']
    
    if params[:posSelect] != "All"
      @currentPos = params[:posSelect]
      if hittingCats.include? params[:statSelect]
        @players = Player.where("ab is not null and team_id=?", params[:playerSelect])
      elsif pitchingCats.include? params[:statSelect]
        @players = Player.where("ip is not null and team_id=?", params[:playerSelect])
      end
    end
    
    if params[:statSelect] != "espnValue"
      puts "SORTING"
      puts params[:statSelect]
      
      if params[:statSelect] == 'AVG'
        @players.sort! {|b,a| a.avg <=> b.avg}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "SB"
        @players.sort! {|b,a| a.sb <=> b.sb}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "HR"
        @players.sort! {|b,a| a.hr <=> b.hr}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "R"
        @players.sort! {|b,a| a.r <=> b.r}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "RBI"
        @players.sort! {|b,a| a.rbi <=> b.rbi}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "PK"
        @players.sort! {|b,a| a.pk <=> b.pk}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "ERA"
        @players.sort! {|a,b| a.era <=> b.era}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "WHIP"
        @players.sort! {|a,b| a.whip <=> b.whip}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "W"
        @players.sort! {|b,a| a.w <=> b.w}
        @currentSort = params[:statSelect]
      elsif params[:statSelect] == "SV"
        @players.sort! {|b,a| a.sv <=> b.sv}
        @currentSort = params[:statSelect]
      end
      puts @players.first.first
    else
      @players.sort! {|b,a| a.espnValue <=> b.espnValue}    
    end
    @teams = Team.where(year_id:2)

    render "index"
    
  end
  
  
  def destroy  
    
    puts "DESTROYING"
    render :nothing => true
  end
  
end
