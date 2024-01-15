Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  
  namespace :api do
    
    namespace :admin do 
      
      resources :products

      resources :product_pictures      
    end  
    
    namespace :users do

      resources :products, only: [:index, :show] do
        collection do
          get 'create_six_products', to: 'products#create_six_products'
          get 'random_six', to: 'products#random_six'
          get 'products_by_category/:category_id', to: 'products#products_by_category'
        end
      end

      resources :product_pictures, only: [:index, :show] 



    end  

    resources :people ,only: [:create,:index, :show, :update]
      

    # sessions actions
    post "/login", to: "sessions#login"
    post "/signup", to: "sessions#signup"
    delete "/logout", to: "sessions#logout" 
  end  

  resources :todos
end
