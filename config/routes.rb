Rails.application.routes.draw do
  root 'list#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  resources :question, only: [:create, :new, :edit, :show, :update]
  post 'question/post_answer'  => 'question#post_answer'
  post 'question/post_reply'  => 'question#post_reply'

  get 'mypage'  => 'mypage#show'
  get 'mypage/edit'  => 'mypage#edit'
  post 'mypage/update'  => 'mypage#update'
  patch 'mypage/update'  => 'mypage#update'
  post 'mypage/update/logo'  => 'mypage#update_logo'
end
