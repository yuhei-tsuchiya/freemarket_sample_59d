Rails.application.routes.draw do
  # root to: 'toppage#index'
  root to: 'items#deteal'
  devise_for :users
  get 'testimages' => 'testimages#index'    # S3テスト用ファイルアップロード画面
  post 'testimages' => 'testimages#create'    # S3テスト用ファイルアップロードのPOST

  # 商品用ルーティング
  resources :items do
    collection do
      get :sell  # 商品出品ページ
    end
  end
end

