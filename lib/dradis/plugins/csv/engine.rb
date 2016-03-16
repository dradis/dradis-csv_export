module Dradis::Plugins::CSV
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::CSV

    include Dradis::Plugins::Base
    provides :export
    description 'Export results in CSV format'


    initializer "dradis-csv.inflections" do |app|
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym('CSV')
      end
    end

    initializer 'dradis-csv.mount_engine' do
      Rails.application.routes.append do
        mount Dradis::Plugins::CSV::Engine => '/export/csv'
      end
    end

  end
end
