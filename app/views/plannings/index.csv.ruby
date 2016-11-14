CSV.generate { |csv|
  csv << @columns.map{ |c| I18n.t('plannings.export_file.' + c.to_s) }
  @planning.customer.plannings.select { |planning| params[:ids].split(',').include?(planning.id.to_s) }.each do |planning|
    render partial: "layouts/csv.csv", formats: [:ruby], locals: { planning: planning, csv: csv }
  end
}
