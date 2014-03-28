class TeamsController < ApplicationController

  def getPositions
    puts params[:id]
    puts "positions"
    @pl = Player.where(["starter_id IS NOT NULL and team_id is ?",params[:id]])
    posArray = [['C1',false], ['C2',false], ['1B',false], ['2B',false], ['SS',false], ['MI',false], ['3B',false],
     ['CI',false],['OF1',false], ['OF2',false], ['OF3',false], ['OF4',false], ['OF5',false], ['DH',false],
      ['P1',false], ['P2',false], ['P3',false], ['P4',false], ['P5',false], ['P6',false], ['P7',false],
       ['P8',false], ['P9',false], ['B',false], ['DL', false]] 

    for p in @pl
    	posArray[p.starter_id][1] = true
    end
    posArray[23] = ['B', false]
    posArray[24] = ['DL', false]

    
    respond_to do |format|
      
        format.json { render :json => posArray }
        format.js { render :layout => false }
      end

  end

  def updatePositions
    
  end
  
end
