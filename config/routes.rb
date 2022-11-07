Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :Api do
    namespace :V1 do
      root to: 'applications#index'
      resources :applications, param: :token do
        resources :chats, param: :number do
          resources :messages, param: :number do
            get 'search', on: :collection
          end
        end
      end
    end
  end
end
