Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do

      resources :users, only: [:create, :destroy, :index, :show, :update]
      resource :session, only: [:create, :destroy]

      resources :servers do 
          resources :channels, only: [:create] do 
                      resources :messages, only: [:create]

          end
      end

      resources :channels, only: [:update, :show, :destroy, :index] do
          #resources :messages, only: [:create]
      end

      resources :conversations, only: [:index, :show, :create, :destroy] do 
          resources :direct_messages, only: [:create]
      end

      resources :messages, only: [:index, :update, :show, :destroy]
      resources :direct_messages, only: [:index, :update, :destroy, :show]

      resources :server_memberships, only: [:create, :destroy]
      resources :conversation_participants, only: [:create, :destroy]
      #resources :friendships, only: [:create, :destroy, :update, :index]
  end
  mount ActionCable.server => "/cable"
  root to: "static_pages#root"

end
