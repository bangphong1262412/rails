Rails.application.routes.draw do
  
  get '/dashboard', to: 'users#dashboard'
  post 'users/edit', to: 'users#update'

  resources :pets do
    member do
      delete :delete_pet_photos
      post :upload_pet_photos
    end
  end

  root 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout', edit: 'profile' }, 
              controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
