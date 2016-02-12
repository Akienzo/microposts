Rails.application.routes.draw do
  get 'users/new'

  root to: 'static_pages#home'    #このようにすることで、app/views/static_pages/home.html.erbの内容がトップページに表示されるようになります。
  get 'signup', to: 'users#new'
  
  resources :users
end
