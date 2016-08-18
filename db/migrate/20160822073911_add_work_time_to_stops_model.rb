class AddWorkTimeToStopsModel < ActiveRecord::Migration
  def change
    add_column :stops, :out_of_working_time, :boolean
    add_column :routes, :out_of_working_time, :boolean
  end
end
