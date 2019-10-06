Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root toはトップページをローカルホスト３０００に表示
  root to: 'home#top'

  get 'home/about', to: 'home#about'

  resources :users

  resources :books

end
