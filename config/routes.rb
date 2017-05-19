Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
  get '/events/:id/edit' => 'events#edit'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'
  post '/events/options' => 'events#create_options'
  post '/events/send_options' => 'events#send_options'
  get '/option_proposals' => 'events#option_proposals'
  post '/option_proposals' => 'events#vote_on_options'
  get '/option_responses' => 'events#option_responses'
  post '/option_send_final' => 'events#send_final'
  # should option methods be in the option model?

  get '/groups' => 'groups#index'
  get '/groups/new' => 'groups#new'
  post '/groups' => 'groups#create'
  get '/groups/:id' => 'groups#show'
  get '/groups/:id/edit' => 'groups#edit'
  patch '/groups/:id' => 'groups#update'
  delete '/groups/:id' => 'groups#destroy'

  get '/groups/:group_id/events' => 'groups#events'

  get '/groupinvitations/:id/accept' => 'group_invitations#accept'
  get '/groupinvitations/:id/decline' => 'group_invitations#decline'
  patch '/eventinvitations/:id' => 'event_invitations#update'

  get '/twilio/process_group_response' => 'texts#process_group_response'

  namespace :api do
    namespace :v1 do
      get '/events' => 'events#index'
      get '/events/:id' => 'events#show'
      get '/events/group_events/:group_id' => 'events#group_events'
    end
  end
end