class AddMajorStatusToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :majorStatus, :int
  end
end
