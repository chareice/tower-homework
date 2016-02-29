Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :teams, only: [:index, :new, :create] do
    resources :projects, only: [:index, :new, :create]
  end

  resources :projects, shallow: true do
    resources :todos, only: [:index, :new, :create, :update]
  end

  resources :sessions, only: [:create, :destroy, :new]
end
