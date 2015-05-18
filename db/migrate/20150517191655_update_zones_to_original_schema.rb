class UpdateZonesToOriginalSchema < ActiveRecord::Migration
  def change

    add_column :zones, :tenant_id, :integer
    add_column :zones, :rate, :float




  end
end
