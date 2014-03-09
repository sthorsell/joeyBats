class AddUserstuffToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :notes, :string
    add_column :players, :value, :integer
    add_column :players, :espnValue, :integer
    add_column :players, :espnId, :integer
  end
end
