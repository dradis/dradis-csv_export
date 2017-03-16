module Dradis
  module Plugins
    module CSV
      class BaseController < Dradis::Plugins::Export::BaseController

        def index
          exporter = Dradis::Plugins::CSV::Exporter.new(export_options)
          csv      = exporter.export

          send_data csv,
            disposition: 'inline',
            filename: "dradis_report-#{Time.now.to_i}.csv",
            type: 'text/csv'
        end
      end

    end
  end
end
