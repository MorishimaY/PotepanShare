Rails.application.routes.draw do
  get '/search', to: 'searches#search'
  root 'home#top'
  get 'rooms/own', to: 'rooms#own', as: 'rooms_own'
  get 'users/profile', to: 'users#profile', as: 'users_profile'
  get 'reservations/confirm', to: 'reservations#confirm', as: 'reservations_confirm'

  resources :rooms do
    collection do
      get :search
      get :search_results
    end
  end

  resources :users, except: [:show, :create] do
    member do
      get 'profile', to: 'users/registrations#edit'
      patch 'profile', to: 'users/registrations#update'
    end
  end
  get 'users/:id', to: 'users#show', as: 'user_show', constraints: { id: /\d+/ }
  resources :reservations do
    collection do
      post :confirm
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'users/profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end