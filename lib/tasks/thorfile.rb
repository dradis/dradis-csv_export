class CSVTasks < Thor
  include Rails.application.config.dradis.thor_helper_module

  namespace "dradis:plugins:csv"

  desc "export", "export issues to a CSV file"
  method_option :output, required: false, type: :string, desc: "the report file to create (if ends in .csv), or directory to create it in"
  def export
    require 'config/environment'

    report_path = options.output || Rails.root.join('tmp')
    unless report_path.to_s =~ /\.csv\z/
      date = DateTime.now.strftime("%Y-%m-%d")
      base_filename = "dradis-report_#{date}.csv"

      report_filename = NamingService.name_file(
        original_filename: base_filename,
        pathname: Pathname.new(report_path)
      )

      report_path = File.join(report_path, report_filename)
    end

    detect_and_set_project_scope

    exporter = Dradis::Plugins::CSVExport::Exporter.new(task_options)
    csv = exporter.export()

    File.open(report_path, 'w') { |f| f.write csv }

    logger.info "Report file created at:\n\t#{report_path}"
  end

end
