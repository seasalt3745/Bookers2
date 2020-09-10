Rails.application.routes.draw do
  devise_for :users
  get 'home/about'
  root 'books#top'
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
