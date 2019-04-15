Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cities#show'
  post '/', to: 'cities#create', as: :new_city

  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'backgrounds#index'
    end
  end
end
