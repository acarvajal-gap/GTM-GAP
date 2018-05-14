Rails.application.routes.draw do
  resources :users do
    member do
      get :master_report
      get :merge
      post :merge_execute
    end
    collection do
      get :search
    end
  end
  resources :mettings
  resources :reports do
    collection do
      get :master
    end
  end
  root to: "mettings#index"
end
