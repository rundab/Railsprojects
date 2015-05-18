class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones, :options => 'ENGINE=MyISAM' do |t|
      t.string :name
      t.integer :sqft
      t.integer :hour_limit
      t.integer :meter_pct
      t.integer :event_id


      t.timestamps null: false
    end
  end
end
