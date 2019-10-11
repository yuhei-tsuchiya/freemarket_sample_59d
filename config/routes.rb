Rails.application.routes.draw do

  get 'card/new'
  get 'card/show'
  get 'credit_cards/new'
  get 'credit_cards/show'


  root to: 'items#index'
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new"
    get "/log_out" => "users#destroy"
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :signup, only:[:new, :create] do
    collection do
      get 'user_info_input'
      get 'phone_number_authentication'
      get 'address_input'
      get 'payment' # ここで、入力の全てが終了する
      get 'done' # 登録完了後のページ
    end
  end

  resources :profiles, only:[:show, :edit] do
    collection do
      get :edit2
    end
  end

  # 商品用ルーティング
  resources :items, only:[:create, :show, :edit, :update, :destroy] do
    collection do
      get :sell                        # 商品出品ページ
      get 'buy/:id' => 'items#buy'     # 商品購入ページ
      get :pay
    end
  end

  # Ajax通信用
  namespace :api do
    get "select_child", to: "categorys#select_child"
    get "display_size", to: "categorys#display_size"
    get "select_burden", to: "categorys#select_burden"
    get "search_brand", to: "categorys#search_brand"
  end

  # クレカ関連
  resources :card, only: [:new, :show, :destroy] do
    collection do
      post 'pay',    to: 'card#pay'
      post 'buy/:id'  => 'card#buy'
    end
  end


end

