class AddInjuryNotesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :injuryNotes, :string
  end
end
