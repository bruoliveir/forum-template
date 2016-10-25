Rails.application.routes.draw do
  get '/discussions/p/:page', defaults: {format: :json}, to: 'discussions#index'
  get '/discussions', to: redirect('/discussions/p/1')
  resources :discussions, defaults: {format: :json}, only: ['create', 'show']
  resources :users, defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
