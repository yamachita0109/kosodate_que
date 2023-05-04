Rails.application.routes.draw do
  get 'question/create'
  get 'question/new'
  get 'question/edit'
  get 'question/show'
  get 'question/update'
  root "list#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  resources :question, only: [:create, :new, :edit, :show, :update]
end
