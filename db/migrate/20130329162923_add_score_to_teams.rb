class AddScoreToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sbcScore, :integer
  end
end
