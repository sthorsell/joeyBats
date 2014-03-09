class AddSbcValueToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :sbcValue, :integer
  end
end
