Rails.application.routes.draw do

  get 'contacts/new'
  get 'contacts/create'

resources "contacts", only: [:new, :create]
  resources :prices

  devise_for :users
  root 'home#index'


  resources :posts do
    resources :comments
  end


  resources :demos

  resources :projects

  get 'pages/our_thing'

  get 'pages/blog'
end
