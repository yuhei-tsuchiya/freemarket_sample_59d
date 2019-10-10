class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = Rails.application.credentials[:api]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      # description: '登録テスト', #なくてもOK
      # email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:api]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:api]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def buy #クレジット購入
    card = Card.where(user_id: current_user.id)

    if card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find(params[:id])
      # 購入した際の情報を元に引っ張ってくる
      # card = Card.where(user_id: current_user.id).first
      card = current_user.card
      # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      # Payjp.api_key = "sk_test_0e2eb234eabf724bfaa4e676"
      Payjp.api_key = Rails.application.credentials[:api]
      # キーをセットする(環境変数においても良い)

      Payjp::Charge.create(
        amount: @item.price, #支払金額
        customer: card.customer_id, #顧客ID
        currency: 'jpy', #日本円
      )
      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      @item.build_transact(buyer_id: current_user.id, seller_id: @item.user.id)
      @item.torihiki_info = 2
      # if @item.update(torihiki_info: 2, buyer_id: current_user.id)
      if @item.save
        flash[:notice] = '購入しました。'
        redirect_to controller: "items", action: 'show'
      else
        flash[:alert] = '購入に失敗しました。'
        # redirect_to controller: "products", action: 'show'
        redirect_to controller: "items", action: 'buy'
      end
      #↑この辺はこちら側のテーブル設計どうりに色々しています
    end
  end
end