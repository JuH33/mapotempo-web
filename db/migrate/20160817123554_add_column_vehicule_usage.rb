class AddColumnVehiculeUsage < ActiveRecord::Migration
  def change
    add_column :vehicle_usages, :working_time, :int
  end
end
