Rails.application.routes.draw do
  resources :assets, only: [:create, :update, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
