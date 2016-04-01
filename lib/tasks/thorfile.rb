class CSVTasks < Thor
  include Dradis::Plugins::thor_helper_module.to_s.constantize

  namespace "dradis:plugins:csv"

  desc "export", "export issues to a CSV file"
  def export
    require 'config/environment'

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    content_service = nil

    detect_and_set_project_scope
    exporter = Dradis::Plugins::CSV::Exporter.new({
      content_service: Dradis::Plugins::ContentService.new(plugin: Dradis::Plugins::CSV)
    })
    csv = exporter.export()

    filename = "dradis-report_#{Time.now.to_i}.csv"
    File.open(filename, 'w') { |f| f.write csv }

    logger.info "File written to ./#{ filename }"

    logger.close
  end

end
