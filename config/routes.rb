Rails.application.routes.draw do

  root to: 'home#index'

  namespace :admin do
    root to: 'home#index'
    resources :departments do
      get '/members' => 'departments#members'
      post '/members' => 'departments#add_member'
      delete '/members/:user_id' => 'departments#remove_member', as: 'remove_member'
    end
  end

  namespace :staff do
    root to: 'home#index'
    resources :departments, only: [:index, :show] do
      get '/members' => 'departments#members'
      post '/members' => 'departments#add_member'
      delete '/members/:user_id' => 'departments#remove_member', as: 'remove_member'
    end
  end

  namespace :participants do
    root to: 'home#index'
  end

end