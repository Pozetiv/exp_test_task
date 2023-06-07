Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :experient_users, only: :create
    end
  end
  resources :experient_users, only: :index
end
