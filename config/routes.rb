Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations",
                                    passwords: "users/passwords"
                                  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :posts, only: [:index, :create]
  resources :friendships, only: [:index, :create] do
    member do
      patch :accept
      delete :cancel
      delete :remove
    end
  end
end
