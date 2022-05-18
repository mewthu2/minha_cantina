Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  # ADMIN routes
  #
  namespace :admin do
    root 'home#index'
    ## Users - >
    resources :users do
      get :dashboard
    end
  end

  # Devise
  # devise_for :users, path: 'admin', path_names: { sign_in: 'login'}
end