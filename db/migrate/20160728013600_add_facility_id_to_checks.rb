class AddFacilityIdToChecks < ActiveRecord::Migration[5.0]
  def change
    add_column :checks, :facility_id, :integer
  end
end
