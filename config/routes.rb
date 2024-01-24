Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  #testing auth 
  get '/know_user' => 'members#index'

  #tasks routes
  get '/tasks' => 'tasks#index'
  post '/task/create' => 'tasks#create'
  patch '/task/:id' => 'tasks#update'
  delete '/task/:id' => 'tasks#destroy'
  
end
