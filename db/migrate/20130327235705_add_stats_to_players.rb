class AddStatsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :g, :integer
    add_column :players, :gs, :integer
    add_column :players, :ip, :float
    add_column :players, :pbb, :integer
    add_column :players, :pk, :integer
    add_column :players, :w, :integer
    add_column :players, :sv, :integer
    add_column :players, :hd, :integer
    add_column :players, :era, :float
    add_column :players, :whip, :float
    add_column :players, :k9, :float
  end
end
