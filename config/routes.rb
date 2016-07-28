Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :facilities
  get '/management', to: 'facilities#facilities'
  root 'facilities#index'
end
