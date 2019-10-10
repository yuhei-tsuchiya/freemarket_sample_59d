Rails.application.routes.draw do

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

  resources :profiles, only:[:show]

  get 'testimages' => 'testimages#index'    # S3テスト用ファイルアップロード画面
  post 'testimages' => 'testimages#create'    # S3テスト用ファイルアップロードのPOST

  

  # 商品用ルーティング
  resources :items do
    collection do
      get :sell   # 商品出品ページ
      get :deteal # 商品詳細ページ
      get :buy    # 商品購入ページ
      get :person_info
    end
  end

  # Ajax通信用
  namespace :api do
    get "select_child", to: "categorys#select_child"
    get "display_size", to: "categorys#display_size"
    get "select_burden", to: "categorys#select_burden"
    get "search_brand", to: "categorys#search_brand"
  end

end

