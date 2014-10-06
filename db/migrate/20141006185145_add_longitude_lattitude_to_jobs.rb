class AddLongitudeLattitudeToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :longitude, :float
    add_column :jobs, :latitude, :float
  end

  def down
    remove_column :jobs, :longitude
    remove_column :jobs, :latitude
  end
end
