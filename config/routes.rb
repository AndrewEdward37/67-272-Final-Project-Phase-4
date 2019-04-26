Rails.application.routes.draw do
#-------------------------------------------------------------------------------    
#Main resources
  resources :assignments
  resources :stores
  resources :employees
  resources :flavors
  resources :jobs
  resources :shifts
  resources :sessions
#-------------------------------------------------------------------------------    
#Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

#-------------------------------------------------------------------------------    
#Routes user needs
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'session/current_user_info' => 'sessions#current_user_info', :as => :view_current_user

#-------------------------------------------------------------------------------    
#The root url
  root :to => 'home#home'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
