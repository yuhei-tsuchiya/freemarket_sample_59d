class SignupController < ApplicationController
  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション

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
    # session["birthday(1i)"]         = birthday_params["birthday(1i)"]
    # session["birthday(2i)"]         = birthday_params["birthday(2i)"]
    # session["birthday(3i)"]         = birthday_params["birthday(3i)"]
    # session["birthday(1i)"]         = user_params["birthday(1i)"]
    # session["birthday(2i)"]         = user_params["birthday(2i)"]
    # session["birthday(3i)"]         = user_params["birthday(3i)"]
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
    session[:address_attributes] = user_params[:address_attributes]
    # step4で入力された値をsessionに保存
    @user = User.new # 新規インスタンス作成
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      lastname_kanji: session[:lastname_kanji], 
      firstname_kanji: session[:firstname_kanji], 
      lastname_kana: session[:lastname_kana], 
      firstname_kana: session[:firstname_kana], 
      birthday: session[:birthday],
      cellphone_number: session[:cellphone_number],

      # "birthday(1i)": session["birthday(1i)"],
      # "birthday(2i)": session["birthday(2i)"],
      # "birthday(3i)": session["birthday(3i)"]
    )
    @user.build_address(session[:address_attributes])

    # session[:id] = @user.id
    # @user.save
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
    # session["birthday(1i)"]         = user_params["birthday(1i)"]
    # session["birthday(2i)"]         = user_params["birthday(2i)"]
    # session["birthday(3i)"]         = user_params["birthday(3i)"]
    session[:birthday]              = birthday_params

    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      lastname_kanji: session[:lastname_kanji], 
      firstname_kanji: session[:firstname_kanji], 
      lastname_kana: session[:lastname_kana], 
      firstname_kana: session[:firstname_kana], 
      birthday: session[:birthday],
      # "birthday(1i)": session["birthday(1i)"],
      # "birthday(2i)": session["birthday(2i)"],
      # "birthday(3i)": session["birthday(3i)"]
      # last_name: "山田", # 入力前の情報は、バリデーションに通る値を仮で入れる
      # cellphone_number: session[:cellphone_number],
      # first_name: "太郎", 
      # last_name_kana: "ヤマダ", 
      # first_name_kana: "タロウ", 
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render step1_signup_index_path unless @user.valid?(:validates_step1)
  end

  def validates_step2
    # step2で入力された値をsessionに保存
    session[:cellphone_number] = user_params[:cellphone_number]
    @user = User.new(
      nickname: session[:nickname], # session1に保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      lastname_kanji: session[:lastname_kanji], 
      firstname_kanji: session[:firstname_kanji], 
      lastname_kana: session[:lastname_kana], 
      firstname_kana: session[:firstname_kana], 
      birthday: session[:birthday],
      cellphone_number: session[:cellphone_number] # session2
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
　　render step2_signup_index_path unless @user.valid?
  end 

  private
    def user_params
      params.require(:user).permit(
        # params.permit(
        :nickname, 
        :email, 
        :password, 
        :password_confirmation, 
        :lastname_kanji, 
        :firstname_kanji, 
        :lastname_kana, 
        :firstname_kana, 
        # :birthday,
        :cellphone_number,

        address_attributes: [:id, :zip_code, :prefecture_id, :jusho_shikuchoson, :jusho_banchi, :jusho_tatemono, :phone_number]
      )
    end

    def birthday_params
      # パラメータ取得
      # date = params[:user][:birthday]
      date = params[:birthday]

      # params[:birthday]
      # session["birthday(1i)"]         = user_params["birthday(1i)"]
      # session["birthday(2i)"]         = user_params["birthday(2i)"]
      # session["birthday(3i)"]         = user_params["birthday(3i)"]
  
      # ブランク時のエラー回避のため、ブランクだったら何もしない
      if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
        return
      end
  
      # 年月日別々できたものを結合して新しいDate型変数を作って返す
      Date.new(date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i)
    end

end
