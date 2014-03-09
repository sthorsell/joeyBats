class CreateAddOurValueToPlayers < ActiveRecord::Migration
  def change
    create_table :add_our_value_to_players do |t|
      t.integer :ourValue

      t.timestamps
    end
  end
end
