class SignupController < ApplicationController
  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション
  before_action :validates_step3, only: :step4 # step3のバリデーション

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
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

  def step3
    # step2で入力された値をsessionに保存
    session[:cellphone_number]      = user_params[:cellphone_number]
    @prefectures = Prefecture.all
    @user = User.new # 新規インスタンス作成
    @user.build_address
  end

  def step4
    # step3で入力された値をsessionに保存
    session[:address_attributes]    = user_params[:address_attributes]
    @user = User.new # 新規インスタンス作成
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def create
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
      render done_signup_index_path
    else
      render step1_signup_index_path
    end
  end

  def validates_step1
    # step1で入力された値をsessionに保存
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
    render step1_signup_index_path unless @user.valid?(:validates_step1)
  end

  def validates_step2
    # step2で入力された値をsessionに保存
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
    render step2_signup_index_path unless @user.valid?(:validates_step2)
  end 

  def validates_step3
    @prefectures = Prefecture.all
    # step3で入力された値をsessionに保存
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
    render step3_signup_index_path unless @user.valid?(:validates_step3)
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

end