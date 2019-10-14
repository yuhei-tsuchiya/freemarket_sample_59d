class SignupController < ApplicationController

  require "payjp"

  before_action :validates_user_info_input, only: :phone_number_authentication # user_info_inputのバリデーション
  before_action :validates_phone_number_authentication, only: :address_input # phone_number_authenticationのバリデーション
  before_action :validates_address_input, only: :payment # address_inputのバリデーション

  def user_info_input
    @user = User.new # 新規インスタンス作成
  end

  def phone_number_authentication
    # user_info_inputで入力された値をsessionに保存
    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:lastname_kanji]        = user_params[:lastname_kanji]
    session[:firstname_kanji]       = user_params[:firstname_kanji]
    session[:lastname_kana]         = user_params[:lastname_kana]
    session[:firstname_kana]        = user_params[:firstname_kana]
    session[:birthday]              = birthday_params
    @user = User.new # 新規インスタンス作成
  end

  def address_input
    # phone_number_authenticationで入力された値をsessionに保存
    session[:cellphone_number]      = user_params[:cellphone_number]
    @prefectures = Prefecture.all
    @user = User.new # 新規インスタンス作成
    @user.build_address
  end

  def payment
    # address_inputで入力された値をsessionに保存
    session[:address_attributes]    = user_params[:address_attributes]
    @user = User.new # 新規インスタンス作成
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def create
    payjp_token = payjp_params.present? ? payjp_params[:payjp_token] : nil
    @user = User.new(
      nickname:                       session[:nickname], # sessionに保存された値をインスタンスに渡す
      email:                          session[:email],
      password:                       session[:password],
      password_confirmation:          session[:password_confirmation],
      lastname_kanji:                 session[:lastname_kanji], 
      firstname_kanji:                session[:firstname_kanji], 
      lastname_kana:                  session[:lastname_kana], 
      firstname_kana:                 session[:firstname_kana], 
      birthday:                       session[:birthday],
      cellphone_number:               session[:cellphone_number],
    )
    @user.build_address(session[:address_attributes])

    if @user.save
      # ログインするための情報を保管
      session[:id] = @user.id
      if payjp_token
        create_card(payjp_token, @user.id)
      else
        redirect_to done_signup_index_path
      end
    else
      render user_info_input_signup_index_path
    end
  end

  def validates_user_info_input
    # user_info_inputで入力された値をsessionに保存
    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:lastname_kanji]        = user_params[:lastname_kanji]
    session[:firstname_kanji]       = user_params[:firstname_kanji]
    session[:lastname_kana]         = user_params[:lastname_kana]
    session[:firstname_kana]        = user_params[:firstname_kana]
    session[:birthday]              = birthday_params

    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nickname:                       session[:nickname], # sessionに保存された値をインスタンスに渡す
      email:                          session[:email],
      password:                       session[:password],
      password_confirmation:          session[:password_confirmation],
      lastname_kanji:                 session[:lastname_kanji], 
      firstname_kanji:                session[:firstname_kanji], 
      lastname_kana:                  session[:lastname_kana], 
      firstname_kana:                 session[:firstname_kana], 
      birthday:                       session[:birthday],
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render user_info_input_signup_index_path unless @user.valid?(:validates_user_info_input)
  end

  def validates_phone_number_authentication
    # phone_number_authenticationで入力された値をsessionに保存
    session[:cellphone_number]      = user_params[:cellphone_number]
    @user = User.new(
      nickname:                       session[:nickname], # sessionに保存された値をインスタンスに渡す
      email:                          session[:email],
      password:                       session[:password],
      password_confirmation:          session[:password_confirmation],
      lastname_kanji:                 session[:lastname_kanji], 
      firstname_kanji:                session[:firstname_kanji], 
      lastname_kana:                  session[:lastname_kana], 
      firstname_kana:                 session[:firstname_kana], 
      birthday:                       session[:birthday],
      cellphone_number:               session[:cellphone_number] # session2
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render phone_number_authentication_signup_index_path unless @user.valid?(:validates_phone_number_authentication)
  end 

  def validates_address_input
    @prefectures = Prefecture.all
    # address_inputで入力された値をsessionに保存
    session[:address_attributes]    = user_params[:address_attributes]
    @user = User.new(
      nickname:                       session[:nickname], # sessionに保存された値をインスタンスに渡す
      email:                          session[:email],
      password:                       session[:password],
      password_confirmation:          session[:password_confirmation],
      lastname_kanji:                 session[:lastname_kanji], 
      firstname_kanji:                session[:firstname_kanji], 
      lastname_kana:                  session[:lastname_kana], 
      firstname_kana:                 session[:firstname_kana], 
      birthday:                       session[:birthday],
      cellphone_number:               session[:cellphone_number], # session2
      address_attributes:             session[:address_attributes], # session3
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render address_input_signup_index_path unless @user.valid?(:validates_address_input)
  end 

  private
    def user_params
      params.require(:user).permit(
        :nickname, 
        :email, 
        :password, 
        :password_confirmation, 
        :lastname_kanji, 
        :firstname_kanji, 
        :lastname_kana, 
        :firstname_kana, 
        :cellphone_number,

        address_attributes: [:id, :zip_code, :prefecture_id, :jusho_shikuchoson, :jusho_banchi, :jusho_tatemono, :phone_number]
      )
    end

    def birthday_params
      # パラメータ取得
      date = params[:birthday]
  
      # ブランク時のエラー回避のため、ブランクだったら何もしない
      if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
        return
      end
  
      # 年月日別々できたものを結合して新しいDate型変数を作って返す
      Date.new(date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i)
    end

    def payjp_params
      if params.has_key?(:payjp_token)
        params.permit(:payjp_token)
      else
        return nil
      end
    end

    # payjpとCardのデータベース作成を実施。card_controller.rbのpayアクションに相当
    def create_card(payjp_token, user_id) 
      Payjp.api_key = Rails.application.credentials[:api]
      customer = Payjp::Customer.create(
        card: payjp_token,
        metadata: {user_id: user_id}
        )
      @card = Card.new(user_id: user_id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to done_signup_index_path
      else
        redirect_to action: "payment"
      end
    end

end