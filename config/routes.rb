Rails.application.routes.draw do
  get 'sessions/new'

  resources :timmings
  resources :providers
  resources :routes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/find' => 'routes#find'
   
  post '/find' => 'routes#find' 
  
  root "routes#find"
  
  get  '/signup',  to: 'providers#new'
  post '/signup',  to: 'providers#create'
  delete '/logout',  to: 'sessions#destroy'
   post   '/login',   to: 'sessions#create'
    get   '/login',   to: 'sessions#new'
  
  match 'homepage' => 'sessions#home', as: :homepage, via: [:get, :post]


  


#post '/routes/find' => 'routes#find', as: '/search'

end
