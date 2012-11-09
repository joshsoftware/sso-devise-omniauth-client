OauthClientDemo::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => 'sessions' }
  
  devise_scope :user do
    get 'sign_in',  :to => 'sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'sessions#destroy', :as => :destroy_user_session
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  
  root :to => 'home#index'
end
