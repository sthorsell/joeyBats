class AddYearIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :year_id, :integer
  end
end
