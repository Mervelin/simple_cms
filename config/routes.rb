Rails.application.routes.draw do

  root 'demo#index'

  get 'admin', to: 'access#menu'
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  resources :admin_users, except: :show do
    member do
      get :delete
    end
  end

  resources :subjects do
    member do
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  get 'credit_cards/open'
  get 'credit_cards/debit'
  get 'credit_cards/credit'
  get 'credit_cards/close'

  get 'demo/index'
  get 'demo/hello'
  get 'demo/other_hello'

  get 'demo/lynda'
  get 'demo/escape_output'

  # default route
  # may go away in future versions of Rails
  # get ':controller(/:action(/:id))'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
