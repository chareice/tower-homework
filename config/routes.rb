Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :teams, only: [:index, :new, :create] do
    resources :projects, only: [:index, :new, :create]
  end
end
