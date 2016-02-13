Rails.application.routes.draw do
  root to: 'static_pages#home'     #このようにすることで、app/views/static_pages/home.html.erbの内容がトップページに表示されるようになります。
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
end


