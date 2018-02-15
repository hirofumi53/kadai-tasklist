Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  
  resources :users, only: [:new, :create]
  
  resources :tasklists, only: [:create, :destroy, :update, :show, :edit]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
