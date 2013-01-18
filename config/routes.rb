Paleoclan::Application.routes.draw do
  root       :to => 'pages#index'
  match '/rules' => 'pages#rules'

  resource  :today
  resources :slots

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
