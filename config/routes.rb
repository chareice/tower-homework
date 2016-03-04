Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :teams, only: [:index, :new, :create] do
    resources :projects, only: [:index, :new, :create]
    resources :events, only: [:index]
  end

  resources :projects, shallow: true do
    resources :todos, only: [:index, :new, :create, :update, :show, :destroy] do
      member do
        #关闭Todo
        patch :close
      end
    end
  end

  resources :todos, shallow: true do
    resources :comments, only: [:create, :index]
  end

  resources :sessions, only: [:create, :destroy, :new]

  root to: 'teams#index'
end
