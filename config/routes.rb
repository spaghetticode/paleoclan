Paleoclan::Application.routes.draw do
  # root  :to => 'pages#index'
  root  :to => 'pages#closed'
  match '/menu'  => 'pages#menu'
  match '/rules' => 'pages#rules'

  resources :slots, :bets
  resources :ratings, :except => [:edit, :destroy]
  resource :today do
    get :roulette
  end

  namespace :admin do
    get '/' => 'settings#edit'
    resource  :settings, :only => [:edit, :update]
    resources :users,    :except => [:edit, :update, :show] do
      delete :destroy
      put :ban, :unban
      resources :credits, :only => :create do
        collection do
          put :use
          delete :destroy
        end
      end
    end
    resources :slots, :only => [:index, :destroy]
    resources :bets,  :only => [:index, :destroy]
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
