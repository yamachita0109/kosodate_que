Rails.application.routes.draw do
  root 'list#index'

  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # 質問
  resources :question, only: [:create, :new, :edit, :show, :update]
  post 'question/post_answer'  => 'question#post_answer'
  get  '/tag/:tag', to: 'list#index'
  get  'question' => redirect('/')

  # プロフィール
  resources :profile, only: [:show]

  # 問い合わせ
  get  'contact'  => 'contact#new'
  post 'contact'  => 'contact#post'

  # マイページ
  get   'mypage'  => 'mypage#show'
  get   'mypage/edit'  => 'mypage#edit'
  post  'mypage/update'  => 'mypage#update'
  patch 'mypage/update'  => 'mypage#update'
  post  'mypage/update/logo'  => 'mypage#update_logo'

  # 静的ページ
  get   'privacy'  => 'static#privacy'
  get   'terms'  => 'static#terms'

  # API
  namespace 'api' do
    get  'question'  => 'question#get'
    get  'answer'  => 'answer#get'
    post 'reply'  => 'reply#post'
    get  'tags'  => 'tags#get'
    get  'ai/answer'  => 'ai_answer#get'
  end

  # get '*path', controller: 'application', action: 'render_404'
end
