class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :company, foriegn_key: true
      t.references :role, foriegn_key: true
      t.timestamps
    end
  end
end
