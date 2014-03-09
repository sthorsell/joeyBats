class HomeController < ApplicationController
  def index
    @currentTeam = Team.first.id
    @currentPos = 'All'
    @currentSort = 'espnValue'
    puts "IDEX"
    @players = Player.find_all_by_team_id(@currentTeam)
    
    @teams = Team.all
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
    
    if params[:posSelect] != "All"
      @currentPos = params[:posSelect]
      @players = Player.where("position like ? and team_id=?", "%#{params[:posSelect]}%", params[:playerSelect])
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
      elsif params[:statSelect] == "PK"
        @players.sort! {|b,a| a.pk <=> b.pk}
        @currentSort = params[:statSelect]
      end
      puts @players.first.first
    else
      @players.sort! {|b,a| a.espnValue <=> b.espnValue}    
    end
    @teams = Team.all

    render "index"
    
  end
  
  
  def destroy  
    
    puts "DESTROYING"
    render :nothing => true
  end
  
end
