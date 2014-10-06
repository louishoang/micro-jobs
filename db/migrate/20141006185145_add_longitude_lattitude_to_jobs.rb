class AddLongitudeLattitudeToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :longitude, :float
    add_column :jobs, :lattitude, :float
  end

  def down
    remove_column :jobs, :longitude
    remove_column :jobs, :lattitude
  end
end
