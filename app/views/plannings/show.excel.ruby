CSV.generate({col_sep: ';'}) { |csv|
  csv << @columns.map{ |c| I18n.t('plannings.export_file.' + c.to_s) }
  render partial: 'layouts/excel.excel', formats: [:csv], locals: {planning: @planning, csv: csv}
}
