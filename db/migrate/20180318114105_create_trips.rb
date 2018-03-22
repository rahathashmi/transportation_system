class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :distance
      t.references :vehicle, foreign_key: true
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      
      t.timestamps
    end
  end
end
