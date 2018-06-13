class AddDeliverableUnitNotManaged < ActiveRecord::Migration
  def change
    add_column :stops, :unmanageble_capacity, :boolean
  end
end
