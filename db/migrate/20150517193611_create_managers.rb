class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers  do |t|
      t.string :name
      t.string :address
      t.integer :tenant_id
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone




      t.timestamps null: false
    end
  end
end
