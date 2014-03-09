class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :first, :last
  
  def i
    self.espnId
  end
end
