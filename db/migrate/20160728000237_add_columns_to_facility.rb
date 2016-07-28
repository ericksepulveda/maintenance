class AddColumnsToFacility < ActiveRecord::Migration[5.0]
  def change
    add_column :facilities, :days_to_check, :integer
  end
end
