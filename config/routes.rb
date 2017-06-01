Rails.application.routes.draw do
  resources :share, only: %i(index create show destroy)
  resources :restore, only: %i(index update)
  resources :recents, only: :index
  resources :favorites, only: %i(index create destroy)

  resources :about, only: :index
  resources :help, only: :index

  resources :folders, only: %i(index show create update destroy) do
    resources :items, only: %i(create destroy show)
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }

  root 'home#index'
end
