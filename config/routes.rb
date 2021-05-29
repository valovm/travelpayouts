Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create] do
        resources :programs, only: %i[index create destroy], module: :users
      end
      resources :programs, only: %i[index] do
        collection do
          get :autocomplete
        end
      end
    end
  end
end
