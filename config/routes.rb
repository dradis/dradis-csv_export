Dradis::Plugins::CSVExport::Engine.routes.draw do
  resources :projects, only: [] do
    resource :report, only: [:create], path: '/export/csv'
  end
end
