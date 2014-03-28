class Team < ActiveRecord::Base
  has_many :players
  attr_accessible :teamName
  
  def teamEra
    @curPlayers = players.where("players.era IS NOT NULL and starter_id < 23")
    a = 0
    for p in @curPlayers
      a = a + p.era * p.ip
    end
    
    if @curPlayers.sum('ip') > 0
      a = a / @curPlayers.sum('ip')
    else
      a = 0
    end
    
  end
  
  def teamWhip
    @curPlayers = players.where("players.whip IS NOT NULL and starter_id < 23")
    a = 0
    for p in @curPlayers
      a = a + p.whip * p.ip
    end
    
    if @curPlayers.sum('ip') > 0
      a = a / @curPlayers.sum('ip')
    else
      a = 0
    end
  end
  
  def teamSv
    @curPlayers = players.where("players.sv IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('sv') > 0
      a = @curPlayers.sum('sv')
    else
      a = 0
    end
  end
  
  
  def teamW
    @curPlayers = players.where("players.w IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('w') > 0
      a = @curPlayers.sum('w')
    else
      a = 0
    end
  end
  
  
  def teamPk
    @curPlayers = players.where("players.pk IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('pk') > 0
      a = @curPlayers.sum('pk')
    else
      a = 0
    end
  end
  
  def teamAvg
      @curPlayers = players.where("players.avg IS NOT NULL and starter_id < 23")
      a = 0
      for p in @curPlayers
        if p.ab !=nil
          a = a + p.avg * p.ab
        end
      end

      if @curPlayers.sum('ab') > 0
        a = a / @curPlayers.sum('ab')
      else
        a = 0
      end   
  end
  
  def teamHr
    @curPlayers = players.where("players.hr IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('hr') > 0
      a = @curPlayers.sum('hr')
    else
      a = 0
    end
  end
  
  def teamR
    @curPlayers = players.where("players.r IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('r') > 0
      a = @curPlayers.sum('r')
    else
      a = 0
    end
  end
  
  def teamSb
    @curPlayers = players.where("players.sb IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('sb') > 0
      a = @curPlayers.sum('sb')
    else
      a = 0
    end
  end
  
  def teamRbi
    @curPlayers = players.where("players.rbi IS NOT NULL and starter_id < 23")
    if @curPlayers.sum('rbi') > 0
      a = @curPlayers.sum('rbi')
    else
      a = 0
    end
  end

  def startingLineup
    starters = Array.new(23)

    startingPlayers = players.where("starter_id IS NOT NULL and starter_id < 23")
    for p in startingPlayers
      starters[p.starter_id] = p;
    end
    return starters
  end

  def benchLineup
    benchPlayers = players.where("starter_id IS NOT NULL and (starter_id is 23 or starter_id is 24)")
    return benchPlayers
  end

  def maxBid
    startingPlayers = players.where("starter_id IS NOT NULL and starter_id < 23")
    dlPlayers = players.where("starter_id IS NOT NULL and starter_id is 24")
    mBid = 260 - (startingPlayers.sum(:sbcValue) + dlPlayers.sum(:sbcValue)) - (23 - startingPlayers.count)
  end

  def available
    startingPlayers = players.where("starter_id IS NOT NULL and starter_id < 23")
    dlPlayers = players.where("starter_id IS NOT NULL and starter_id is 24")
    left = 260 - (startingPlayers.sum(:sbcValue) + dlPlayers.sum(:sbcValue)) 
  end
  
end
