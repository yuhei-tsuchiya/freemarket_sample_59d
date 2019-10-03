Rails.application.routes.draw do
  # root to: 'toppage#index'
  root to: 'items#deteal'
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   resources :signup do
#     collection do
#       get 'step1'
#       get 'step2'
#       get 'step3'
#       get 'step4' # ここで、入力の全てが終了する
#       get 'done' # 登録完了後のページ
#     end
#   end

  get 'testimages' => 'testimages#index'    # S3テスト用ファイルアップロード画面
  post 'testimages' => 'testimages#create'    # S3テスト用ファイルアップロードのPOST

  # 商品用ルーティング
  resources :items do
    collection do
      # get :sell  # 商品出品ページ
      get 'sell' => 'items#sell'  # 商品出品ページ
      get 'sell/:id' => 'items#sell'  # 商品出品ページ
    end
  end

  # Ajax通信用
  namespace :api do
    get "select_child", to: "categorys#select_child"
  end

end

