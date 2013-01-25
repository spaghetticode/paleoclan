Paleoclan::Application.routes.draw do
  root  :to => 'pages#index'
  match '/menu'  => 'pages#menu'
  match '/rules' => 'pages#rules'

  resources :slots, :bets
  resource :today do
    get :roulette
  end

  namespace :admin do
    get '/' => 'settings#edit'
    resource  :settings, :only => [:edit, :update]
    resources :users,    :except => [:edit, :update, :show] do
      delete :destroy
      put :ban, :unban
    end
    resources :slots, :only => [:index, :destroy]
    resources :bets,  :only => [:index, :destroy]
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
