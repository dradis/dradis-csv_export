module Dradis::Plugins::CSVExport
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::CSVExport

    include Dradis::Plugins::Base
    provides :export
    description 'Export results in CSV format'

    initializer 'dradis-csv_export.inflections' do |app|
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym('CSV')
      end
    end

    initializer 'dradis-csv_export.mount_engine' do
      Rails.application.routes.append do
        mount Dradis::Plugins::CSVExport::Engine => '/export/csv', as: :csv_export
      end
    end
  end
end
