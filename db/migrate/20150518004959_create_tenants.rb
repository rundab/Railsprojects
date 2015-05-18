class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants, :options => 'ENGINE=MyISAM' do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :note
      t.string :phone
      t.float :surcharge
      t.integer :manager_id
      t.string :refnum
      t.string :suite
      t.string :email

      t.timestamps null: false
    end
  end
end
