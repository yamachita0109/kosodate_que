Rails.application.routes.draw do
  root 'list#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  resources :question, only: [:create, :new, :edit, :show, :update]
  get 'mypage'  => 'mypage#show'
  get 'mypage/edit'  => 'mypage#edit'
  post 'mypage/update'  => 'mypage#update'
end
