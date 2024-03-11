Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'

  resources :categories do
    resources :to_dos do
      member do
        patch :toggle_completion
      end
    end
  end
  get "/categories", to: "categories#index"
  get 'categories/new', to: 'categories#new'
  get 'categories/:id', to: 'categories#show'

  delete 'sign_out', to: 'devise/sessions#destroy', as: :debug_sign_out

end
