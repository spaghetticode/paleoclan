Paleoclan::Application.routes.draw do
  root :to => 'pages#index'

  resource  :today
  resources :slots

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
