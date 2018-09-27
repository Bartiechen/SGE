Rails.application.routes.draw do

  root to: 'home#index'

  namespace :admin do
    root to: 'home#index'
    resources :departments do

      get '/members' => 'department_users#index'
      delete '/members/:user_id' => 'department_users#destroy', as: 'destroy_member'
      post '/add-member' => 'department_users#add_member'
    end
  end

  namespace :participants do
    root to: 'home#index'
  end

end