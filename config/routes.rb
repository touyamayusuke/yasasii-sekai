Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "boards#index", as: :authenticated_root
  end

  root "pages#landing"

  resources :boards do
    resources :posts, only: [ :create, :destroy ]
  end
end
