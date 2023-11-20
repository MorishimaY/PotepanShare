Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/own'
  get 'home/top'
  root 'home#top'
  get 'users/show'
  get 'users/profile'
  get 'rooms/new'
  resources :rooms
  resources :users


  #devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
