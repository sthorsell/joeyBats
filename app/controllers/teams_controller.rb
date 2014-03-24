class TeamsController < ApplicationController

  def getPositions
    puts params
    puts "positions"
    @pl = Player.where("starter_id IS NOT NULL", team:2)
    posArray = ['C1', 'C2', '1B', '2B', 'SS', 'MI', '3B', 'CI','OF1', 'OF2', 'OF3', 'OF4', 'OF5', 'DH',
      'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'P9', 'B'] 
      
    for p in @pl
    	posArray[p.starter_id] = ''
    end
    
    

    
  
    respond_to do |format|
      
        format.json { render :json => posArray }
        format.js { render :layout => false }
      end

  end
  
end
