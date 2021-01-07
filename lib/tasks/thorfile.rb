class CSVTasks < Thor
  include Rails.application.config.dradis.thor_helper_module

  namespace "dradis:plugins:csv"

  desc "export", "export issues to a CSV file"
  def export
    require 'config/environment'

    detect_and_set_project_scope

    exporter = Dradis::Plugins::CSV::Exporter.new(task_options)
    csv = exporter.export()

    date = DateTime.now.strftime("%Y-%m-%d")
    base_filename = "dradis-report_#{date}.csv"

    filename = NamingService.name_file(
      original_filename: base_filename,
      pathname: Rails.root
    )

    File.open(filename, 'w') { |f| f.write csv }

    logger.info "File written to ./#{ filename }"
  end

end
