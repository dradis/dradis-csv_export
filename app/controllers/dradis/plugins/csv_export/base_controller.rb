module Dradis
  module Plugins
    module CSVExport
      class BaseController < Dradis::Plugins::Export::BaseController
        before_action :validate_scope

        def index
          exporter = Dradis::Plugins::CSVExport::Exporter.new(
            export_options.merge(scope: @scope.to_sym)
          )
          csv = exporter.export

          send_data csv,
            disposition: 'inline',
            filename: "dradis_report-#{Time.now.to_i}.csv",
            type: 'text/csv'
        end

        private

        def validate_scope
          @scope = params[:scope]

          unless @scope == 'all' || @scope == 'published'
            raise 'Something fishy is going on...'
          end
        end
      end
    end
  end
end
