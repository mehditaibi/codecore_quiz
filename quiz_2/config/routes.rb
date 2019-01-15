Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  
  resources :users, only: [:new, :create]

  get("/", to: "home#index", as: :root)
end
