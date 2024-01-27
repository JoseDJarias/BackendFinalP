Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  
  namespace :api do
    
    namespace :admin do 

      patch 'available_state/:id', to: 'products#available_state'

      get 'available_products', to: 'products#available_products'    
      
      patch 'update_stock/:id', to: 'products#update_stock'

      resources :payment_methods do
        collection do
          patch 'available_state/:id', to: 'payment_methods#available_state'
          get 'available_payment_methods', to: 'payment_methods#available_payment_methods'      
        end

      end  
      
      resources :products

      resources :bills 

      resources :product_pictures    
      
      resources :user_roles
      
      resources :categories do
        collection do
          get 'available_categories', to: 'categories#available_categories'      
          patch 'available_state/:id', to: 'categories#available_state'

        end  

      end  
    end  
    
    namespace :users do

      resources :products, only: [:index, :show] do
        collection do
          get 'random_six', to: 'products#random_six'
          get 'products_by_category/:category_id', to: 'products#products_by_category'
          get 'categories_index', to: 'products#categories_index' 
          post 'filter_by_price_range', to: 'products#filter_by_price_range'   
        end
      end

      resources :product_pictures, only: [:index, :show] 



    end  

    resources :people ,only: [:create,:index, :show, :update] do

      collection do
        post 'create_phone_number/:id', to: 'people#create_phone_number'

      end
    end
      

    # sessions actions
    post "/login", to: "sessions#login"
    post "/signup", to: "sessions#signup"
    delete "/logout", to: "sessions#logout" 
  end  

  resources :todos
end
