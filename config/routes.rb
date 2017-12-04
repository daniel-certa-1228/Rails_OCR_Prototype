Rails.application.routes.draw do
  resources :docs do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'docs#index'
  get 'docs/search', to: 'docs#search', as: 'search'
  get 'docs/send_pdf/:id', to: 'docs#send_pdf', as: 'send'
  post '/docs/send_pdf/mail_it', to: 'docs#mail_it', as: 'mail'
end
