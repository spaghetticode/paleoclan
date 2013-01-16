Paleoclan::Application.routes.draw do
  get "pages/index"
  get "pages/protect"

  root :to => 'pages#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
