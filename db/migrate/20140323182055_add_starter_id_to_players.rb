class AddStarterIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :starter_id, :int
  end
end
