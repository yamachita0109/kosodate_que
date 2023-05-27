Rails.application.routes.draw do
  root 'list#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :question, only: [:create, :new, :edit, :show, :update]
  post 'question/post_answer'  => 'question#post_answer'
  get  '/tag/:tag', to: 'list#index'
  get  'question' => redirect('/')

  resources :profile, only: [:show]

  get  'contact'  => 'contact#new'
  post 'contact'  => 'contact#post'

  get   'mypage'  => 'mypage#show'
  get   'mypage/edit'  => 'mypage#edit'
  post  'mypage/update'  => 'mypage#update'
  patch 'mypage/update'  => 'mypage#update'
  post  'mypage/update/logo'  => 'mypage#update_logo'

  namespace 'api' do
    get  'answer'  => 'answer#get'
    post 'reply'  => 'reply#post'
    get  'tags'  => 'tags#get'
  end

  # get '*path', controller: 'application', action: 'render_404'
end
