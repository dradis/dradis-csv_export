class CSVTasks < Thor
  include Rails.application.config.dradis.thor_helper_module

  namespace "dradis:plugins:csv"

  desc "export", "export issues to a CSV file"
  def export
    require 'config/environment'

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG

    detect_and_set_project_scope

    exporter = Dradis::Plugins::CSV::Exporter.new
    csv = exporter.export()

    filename = "dradis-report_#{Time.now.to_i}.csv"
    File.open(filename, 'w') { |f| f.write csv }

    logger.info "File written to ./#{ filename }"

    logger.close
  end

end
