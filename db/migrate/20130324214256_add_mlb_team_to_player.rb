class AddMlbTeamToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :mlbTeam, :string
  end
end
