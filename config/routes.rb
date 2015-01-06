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
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
