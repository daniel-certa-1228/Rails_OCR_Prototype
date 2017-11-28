Rails.application.routes.draw do
  resources :docs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'docs#index'
end
