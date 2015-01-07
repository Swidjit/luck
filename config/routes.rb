Rails.application.routes.draw do

  devise_for :users

  resources :games, :only => [:index, :show] do
    member do
      post 'save_score'
    end
    collection do
      get 'spot_value'
    end
  end

  resources :comments, :only => [:create, :destroy]

  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages

end
