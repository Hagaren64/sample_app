SampleApp::Application.routes.draw do
  #get "users/new"

  resources :users #allows for REST-style users URL (users/1 goes to users#show)

  match '/signup',  :to => 'users#new'
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
    
  root :to => 'pages#home'
  
  get "pages/home"

  get "pages/contact"

  get "pages/about"



end
