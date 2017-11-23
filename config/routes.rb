Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get "/posts", to: "posts#index"
  get 'tags/:tag', to: 'posts#index', as: "tag"
  root "static_pages#home"
  devise_for :users,
   :controllers => {:omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:index, :show]
  resources :posts
end
