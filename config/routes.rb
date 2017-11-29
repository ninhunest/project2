Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  get "/posts", to: "posts#index"
  get 'tags/:tag', to: 'posts#index', as: "tag"
  root "static_pages#home"
  devise_for :users,
   :controllers => {:omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
