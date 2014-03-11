class AddActiveToYears < ActiveRecord::Migration
  def change
    add_column :years, :active, :boolean
  end
end
