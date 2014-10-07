class AddAddressInUsers < ActiveRecord::Migration
  def up
    add_column :users, :address, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end

  def down
    remove_column :users, :address, :string
    remove_column :users, :latitude, :float
    remove_column :users, :longitude, :float
  end
end
