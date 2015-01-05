Rails.application.routes.draw do
  devise_for :users
  resources :games, :only => [:show] do
    member do
      post 'save_score'
    end
  end
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
