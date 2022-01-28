Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      root to: "applications#index"
      resources :applications, param: :token  do
        resources :chats , param: :number do
          resources :messages, param: :number
          get "/messages_search", to: 'messages#search'
        end
      end
    end
  end
end
