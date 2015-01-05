Rails.application.routes.draw do
  devise_for :users
  resources :games, :only => [:show]
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
