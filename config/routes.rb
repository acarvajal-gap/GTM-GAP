Rails.application.routes.draw do
  resources :users do
    member do
      get :report
    end
  end
  resources :mettings
  root to: "mettings#index"
end
