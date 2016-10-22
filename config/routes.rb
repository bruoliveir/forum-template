Rails.application.routes.draw do
  resources :discussions, defaults: {format: :json}, only: ['index', 'create', 'new', 'show']
  resources :users, defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
