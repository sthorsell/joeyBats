class AddStarterToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :starter, :int
  end
end
