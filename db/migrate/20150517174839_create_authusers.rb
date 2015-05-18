class CreateAuthusers < ActiveRecord::Migration
  def change
    create_table :authusers do |t|
      t.column :name, :string
      t.column :hashed_password, :string
      t.column :level, :integer


      t.timestamps null: false
    end
  end
end
