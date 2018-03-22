Rails.application.routes.draw do
  
  use_doorkeeper do
      skip_controllers :authorizations, :applications,
        :authorized_applications
    end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    devise_for :users
    
    resources :trips, only: [:index, :create]
    get '/trips_summary' => "trips#trips_summary"
  end
end
