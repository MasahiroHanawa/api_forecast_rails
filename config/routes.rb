Rails.application.routes.draw do
  resources :index

  resources :users, only: :create do
    collection do
      post 'confirm'
      post 'login'
      post 'login_check'
    end
  end

  resources :forecast

  root :to => 'index#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
