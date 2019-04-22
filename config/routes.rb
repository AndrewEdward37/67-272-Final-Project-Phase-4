Rails.application.routes.draw do
  resources :store_flavors
  resources :shift_jobs
  resources :flavors
  resources :jobs
  resources :shifts
  # get 'home/home'
  # get 'home/about'
  # get 'home/privacy'
  # get 'home/contact'
  resources :assignments
  resources :stores
  resources :employees
  
  
  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # Set the root url
  root :to => 'home#home'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
