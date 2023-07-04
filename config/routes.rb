Dradis::Plugins::CSVExport::Engine.routes.draw do
  resources :projects, only: [] do
    resource :export, only: [:create]
  end
end
