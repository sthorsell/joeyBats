class Team < ActiveRecord::Base
  has_many :players
  attr_accessible :teamName
  
  def teamEra
    @curPlayers = players.where("players.era IS NOT NULL")
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
    @curPlayers = players.where("players.whip IS NOT NULL")
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
    @curPlayers = players.where("players.sv IS NOT NULL")
    if @curPlayers.sum('sv') > 0
      a = @curPlayers.sum('sv')
    else
      a = 0
    end
  end
  
  
  def teamW
    @curPlayers = players.where("players.w IS NOT NULL")
    if @curPlayers.sum('w') > 0
      a = @curPlayers.sum('w')
    else
      a = 0
    end
  end
  
  
  def teamPk
    @curPlayers = players.where("players.pk IS NOT NULL")
    if @curPlayers.sum('pk') > 0
      a = @curPlayers.sum('pk')
    else
      a = 0
    end
  end
  
  def teamAvg
      @curPlayers = players.where("players.avg IS NOT NULL")
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
    @curPlayers = players.where("players.hr IS NOT NULL")
    if @curPlayers.sum('hr') > 0
      a = @curPlayers.sum('hr')
    else
      a = 0
    end
  end
  
  def teamR
    @curPlayers = players.where("players.r IS NOT NULL")
    if @curPlayers.sum('r') > 0
      a = @curPlayers.sum('r')
    else
      a = 0
    end
  end
  
  def teamSb
    @curPlayers = players.where("players.sb IS NOT NULL")
    if @curPlayers.sum('sb') > 0
      a = @curPlayers.sum('sb')
    else
      a = 0
    end
  end
  
  def teamRbi
    @curPlayers = players.where("players.rbi IS NOT NULL")
    if @curPlayers.sum('rbi') > 0
      a = @curPlayers.sum('rbi')
    else
      a = 0
    end
  end
  
end
