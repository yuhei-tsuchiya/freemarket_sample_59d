Rails.application.routes.draw do
  root to: 'toppage#index'
  devise_for :users
  get 'testimages' => 'testimages#index'    # S3テスト用ファイルアップロード画面
  post 'testimages' => 'testimages#create'    # S3テスト用ファイルアップロードのPOST

end
