class AddNotesToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :espnNotes, :string
  end
end
