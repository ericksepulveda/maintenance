class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.date :date
      t.integer :cost

      t.timestamps
    end
  end
end
