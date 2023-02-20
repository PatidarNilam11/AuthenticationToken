Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  root "posts#index"
  resources :posts do
    member do
    put 'like_post'
  end

  
  collection do
    get :search
    # get :service_posts
  end
end
end
