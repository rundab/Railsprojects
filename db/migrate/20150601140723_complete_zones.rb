class CompleteZones < ActiveRecord::Migration
  def change
    add_column :zones, :bill_type, :string, :limit => 2
    add_column :zones, :size, :float
    add_column :zones, :ot_charge, :decimal, :precision => 5, :scale => 2, :default => 7.36
    add_column :zones, :ovr_period, :float, :limit => 2, :default => 2.0
    add_column :zones, :meter_int, :integer, :limit => 4


  end
end
