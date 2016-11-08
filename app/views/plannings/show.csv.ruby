CSV.generate { |csv|
  csv << @columns.map{ |c| I18n.t('plannings.export_file.' + c.to_s) }
  @planning.customer.plannings.select { |planning| params[:id].split(',').include?(planning.id.to_s) }.each do |planning|
    planning.routes.select{ |route| route.stops.size > 0 }.select{ |route|
    route.vehicle_usage || !@params.key?(:stops) || @params[:stops].split('|').include?('out-of-route')
    }.collect { |route|
      render 'routes/show', route: route, csv: csv
    }.join('')
  end
}
