Rails.application.routes.draw do
  # root to: 'toppage#index'
  root to: 'users#mypage'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   resources :signup do
#     collection do
#       get 'step1'
#       get 'step2'r
#       get 'step3'
#       get 'step4' # ここで、入力の全てが終了する
#       get 'done' # 登録完了後のページ
#     end
#   end

  resources :signup, only:[:new, :create] do
    collection do
      get 'user_info_input'
      get 'phone_number_authentication'
      get 'address_input'
      get 'payment' # ここで、入力の全てが終了する
      get 'done' # 登録完了後のページ
    end
  end


  get 'testimages' => 'testimages#index'    # S3テスト用ファイルアップロード画面
  post 'testimages' => 'testimages#create'    # S3テスト用ファイルアップロードのPOST

  # 商品用ルーティング
  resources :items do
    collection do
      get :sell   # 商品出品ページ
      get :deteal # 商品詳細ページ
      get 'buy/:id' => 'items#buy'   # 商品購入ページ
    end
  end
end

