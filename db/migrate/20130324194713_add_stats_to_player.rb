class AddStatsToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :ab, :integer
    add_column :players, :r, :integer
    add_column :players, :hr, :integer
    add_column :players, :rbi, :integer
    add_column :players, :bb, :integer
    add_column :players, :k, :integer
    add_column :players, :sb, :integer
    add_column :players, :avg, :float
    add_column :players, :obp, :float
    add_column :players, :slg, :float
    add_column :players, :ops, :float
  end
end
