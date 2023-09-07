$:.push File.expand_path('../lib', __FILE__)
require 'dradis/plugins/csv_export/version'
version = Dradis::Plugins::CSVExport::VERSION::STRING

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.platform = Gem::Platform::RUBY
  spec.name = 'dradis-csv_export'
  spec.version = version
  spec.summary = 'CSV export plugin for the Dradis Framework.'
  spec.description = 'This plugin allows you to export your Dradis results in CSV format.'

  spec.license = 'GPL-2'

  spec.authors = ['Daniel Martin']
  spec.homepage = 'https://dradis.com/support/guides/reporting/export_csv.html'

  spec.files = `git ls-files`.split($\)
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})

  # By not including Rails as a dependency, we can use the gem with different
  # versions of Rails (a sure recipe for disaster, I'm sure), which is needed
  # until we bump Dradis Pro to 4.1.
  # s.add_dependency 'rails', '~> 4.1.1'
  spec.add_dependency 'dradis-plugins', '>= 4.8.0'

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake', '>= 12.3.3'

  spec.add_development_dependency 'rspec-rails'#, '~> 3.0.0'
end
