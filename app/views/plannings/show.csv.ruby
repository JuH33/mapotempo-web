CSV.generate { |csv|
  csv << @columns.map{ |c| I18n.t('plannings.export_file.' + c.to_s) }
  render partial: "layouts/csv.csv.ruby", formats: [:csv], locals: { planning: @planning, csv: csv }
}
