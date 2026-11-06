module Dradis
  module Plugins
    module CSVExport
      class ReportsController < Dradis::Plugins::Export::BaseController
        skip_before_action :validate_template

        def create
          exporter = Dradis::Plugins::CSVExport::Exporter.new(export_params)
          csv = exporter.export
          filename = "dradis_report-#{Time.now.to_i}.csv"

          track_download(filename: filename, size: csv.bytesize) if defined?(Dradis::Pro)

          send_data csv,
            disposition: 'inline',
            filename: filename,
            type: 'text/csv'
        end
      end
    end
  end
end
