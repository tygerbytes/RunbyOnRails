Rails.application.routes.draw do

  namespace :static_pages, path: '/' do
    get 'about'
    get 'health_check'
  end

  get 'target_pace/calc'

  root 'target_pace#index'

  # API
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    resources :target_paces, only: :index

    resources :run_types, only: :index
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
