Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  delete '/users/:id' => 'users#destroy'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/' => 'events#index'
  get '/events' => 'events#index'
  get '/events/new' => 'events#new'
  post '/events' => 'events#create'
  get '/events/:id' => 'events#show'
  # get '/events/:id/edit' => 'events#edit'
  patch '/events/:id/cancel' => 'events#cancel'
  post '/events/options' => 'events#create_options'
  post '/events/send_options' => 'events#send_options'
  get '/option_proposals' => 'events#option_proposals'
  post '/option_proposals' => 'events#vote_on_options'
  get '/option_responses' => 'events#option_responses'
  post '/option_send_final' => 'events#send_final'
  # should option methods be in the option controller?

  get '/groups' => 'groups#index'
  get '/groups/new' => 'groups#new'
  post '/groups' => 'groups#create'
  get '/groups/:id' => 'groups#show'
  get '/groups/:id/edit' => 'groups#edit'
  patch '/groups/:id' => 'groups#update'
  delete '/groups/:id' => 'groups#destroy'
  get '/add_friends' => 'groups#add_friends'
  post '/add_friends' => 'groups#create_friendships'

  get '/groups/:group_id/events' => 'groups#events'

  get '/groupinvitations/:id/accept' => 'group_invitations#accept'
  get '/groupinvitations/:id/decline' => 'group_invitations#decline'
  patch '/eventinvitations/:id' => 'event_invitations#update'

  post '/twilio/process_response' => 'twilio#process_response'

  get '/notifications' => 'notifications#index'
  # mark as read

  namespace :api do
    namespace :v1 do
      get '/events' => 'events#index'
      get '/events/:id' => 'events#show'
      get '/events/group_events/:group_id' => 'events#group_events'
    end
  end
end