Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  delete "destroy_user_session", to: "devise/sessions#destroy"
  devise_scope :user do
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
    get "user_show", to: "users/registrations#show"
    get "user_destroy", to: "users/sessions#index"
  end
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show]
  resources :items, only: [:index, :new, :create, :update, :show, :destroy] do
    resources :images, only: [:new, :create]
  end

  resources :items do 
    #Ajaxで動くアクションのルート
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
