class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.references :company, foriegn_key: true
      t.timestamps
    end
  end
end
