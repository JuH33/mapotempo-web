json.stores @planning ? @planning.routes.select(&:vehicle_usage).collect{ |route| [route.vehicle_usage.default_store_start, route.vehicle_usage.default_store_stop, route.vehicle_usage.default_store_rest] }.flatten.compact.uniq : @zoning.customer.stores do |store|
  json.extract! store, :id, :name, :street, :postalcode, :city, :country, :lat, :lng, :color, :icon, :icon_size
end
index = 0
json.zoning @zoning.zones do |zone|
  json.extract! zone, :id, :name, :vehicle_id, :polygon, :speed_multiplicator
  json.index index += 1
end
if @planning
  json.planning @planning.routes do |route|
    if route.vehicle_usage
      json.vehicle_id route.vehicle_usage.vehicle.id
    end
    json.stops route.stops.select{ |stop| stop.is_a?(StopVisit) }.collect do |stop|
      visit = stop.visit
      json.extract! visit, :id
      json.extract! visit.destination, :id, :name, :street, :detail, :postalcode, :city, :country, :lat, :lng, :phone_number, :comment
      json.ref visit.ref if @zoning.customer.enable_references
      json.active route.vehicle_usage && stop.active
      if !@planning.customer.enable_orders
        json.quantities visit.default_quantities.map{ |k, v| {deliverable_unit_id: k, quantity: v} } do |quantity|
          json.extract! quantity, :deliverable_unit_id, :quantity
        end
      end
      (json.duration l(visit.take_over.utc, format: :hour_minute_second)) if visit.take_over
      (json.open1 l(stop.open1.utc, format: :hour_minute)) if stop.open1
      (json.close1 l(stop.close1.utc, format: :hour_minute)) if stop.close1
      (json.open2 l(stop.open2.utc, format: :hour_minute)) if stop.open2
      (json.close2 l(stop.close2.utc, format: :hour_minute)) if stop.close2
      (json.color visit.color) if visit.color
      (json.icon visit.icon) if visit.icon
    end
  end
end
