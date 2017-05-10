Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # get '/users/:id' => 'users#show' # NTH profile
  # get '/users/:id/edit' => 'users#edit' # NTH edit profile
  # patch '/users/:id' => 'users#update' # NTH update profile
  delete '/users/:id' => 'users#destroy'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/' => 'events#index'
  get '/events' => 'events#index'
  get '/events/new' => 'events#new'
  post '/events' => 'events#create'
  get '/events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'

  get '/groups' => 'groups#index'
  get '/groups/new' => 'groups#new'
  post '/groups' => 'groups#create'
  get '/groups/:id' => 'groups#show'
  get '/groups/:id/edit' => 'groups#edit'
  patch '/groups/:id' => 'groups#update'
  delete '/groups/:id' => 'groups#destroy'

  get '/groups/:group_id/events' => 'groups#events'

  patch '/groupinvitations/:id/accept' => 'group_invitations#update'
  patch '/eventinvitations/:id' => 'event_invitations#update'

  get '/options' => 'options#index'
  get '/options/new' => 'options#new'
  post '/options' => 'options#create'
  get '/presented_options' => 'options#presented_options'
end