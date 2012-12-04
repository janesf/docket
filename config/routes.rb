Docket1::Application.routes.draw do
  resources :clubs

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :usercases
  resources :sessions
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :rstatuses

  resources :mytests

  resources :events

  resources :tasks

  resources :refdttypes

  resources :casewatchings

  resources :actionrulelinks

  resources :rulereminderlinks

  resources :entitytypes

  resources :aactions
  
  resources :types do 
    resources :aactions do
      resources :reminders
    end
  end

  resources :rtypes
  
  resources :types do 
    resources :rules 
  end    
  resources :events do 
    resources :rules 
  end
  resources :rules 

  resources :inventorships

  resources :invents

  resources :inventors

  resources :caseinventors

  resources :inventors
  resources :aactions
  resources :countrycodes
  resources :user_reminders
  resources :reminders
  resources :entities
  resources :patentcases
  resources :priorities
  resources :entities
  resources :roles
  resources :movies
  resources :admin
  get "users/new"
  get "static_pages/home"
  get "static_pages/help"

  root to: 'sessions#new'
  #root to: 'static_pages#home'
#  root to: 'movies#index'
 # resources :users
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/admin', to: 'admin#login'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/reminders', to: 'reminders#index'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :entities do
    resources :patentcases do
      resources :aactions do
        resources :reminders
      end  
    end
    resources :inventors
  end
  resources :aactions do
    resources :reminders
  end
  
  resources :entities do
    resources :patentcases do
        resources :reminders
    end
  end
  resources :patentcases do
      resources :reminders
  end
  resources :patentcases do
    resources :aactions do 
        resources :reminders
      end
  end
  
  
  get "static_pages/home"
  get "static_pages/help"
   get "static_pages/about"
   get "static_pages/contact"
   match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'
    match '/', to: 'static_pages#home'
    match '/signup',  to: 'users#new'
    match '/signin',  to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete
  

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
