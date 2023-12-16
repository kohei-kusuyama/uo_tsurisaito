Rails.application.routes.draw do
  #--------------deviseの設定-----------------
  #ゲストログイン
  devise_scope :user do
  post "/public/users/guest_sign_in" => "public/users/sessions#guest_sign_in"
  end

  #会員用
  #URL /users/sign_in...
  devise_for :users, path: :users, skip: [:passwords], controllers: {
    registrations: "public/users/registrations",
    sessions: 'public/users/sessions'
  }

  #管理者用
  #URL /admin/sign_in...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #管理者用
  #URL /admin/sign_in..
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    # get 'users/index'
    # get 'users/show'
    # get 'users/edit'
    # patch 'users/update'
  end

  namespace :admin do
    get "/admin" => "admin/homes#top"
  end

  #会員用
  #URL /sign_in...
    root to: "public/homes#top"
    # get 'homes/top'
    get 'homes/about' => "public/homes#about"

  #scope module:を使用してURLからpublicを消す
  scope module: :public do
     resources :fishing, only: [:index, :create]
    get 'fishing/index'
    get 'fishing/create'
  end

  scope module: :public do
    resources :posts, only: [:new, :index,:show,:edit,:create,:destroy,:update]
  end

  scope module: :public do
    resources :posts do
      resources :post_comments, only: [:index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  scope module: :public do
    get "users/my_page" => "users#my_page"
    get 'users/check' => "users#check"
    patch 'users/withdraw' => 'users#withdraw'
    get 'users/favorites' => 'users#favorites'
    resources :users, only: [:show,:edit,:update]
  end

  scope module: :public do
    resources :users do
      resource :relationships, only: [:create, :destroy]
        get "follower" => "relationships#follower", as: "follower"
        get "followed" => "relationships#followed", as: "followed"
    end
  end

  scope module: :public do
    get "search" => "searches#search"
  end

  # #--------------deviseの設定-----------------
  # #顧客用
  # #URL /users/sign_in...
  # devise_for :users, skip: [:passwords], controllers: {
  #   registrations: "public/users/registrations",
  #   sessions: 'public/users/sessions'
  # }




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end