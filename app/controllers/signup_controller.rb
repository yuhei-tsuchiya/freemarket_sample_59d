class SignupController < ApplicationController

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # binding.pry
    # step1で入力された値をsessionに保存
    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:lastname_kanji]        = user_params[:lastname_kanji]
    session[:firstname_kanji]       = user_params[:firstname_kanji]
    session[:lastname_kana]         = user_params[:lastname_kana]
    session[:firstname_kana]        = user_params[:firstname_kana]
    # session[:birthday]              = birthday_join[:birthday]
    session[:birthday]              = birthday_join
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
      # params[:user][:birthday] = birthday_join,
      birthday: session[:birthday],
      cellphone_number: session[:cellphone_number],
    )
    @user.build_address(session[:address_attributes])

    # session[:id] = @user.id
    # @user.save
    if @user.save
      # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      redirect_to step1_signup_index_path
    end

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

    # def birthday_params
    #   params.require(:birthday).permit(
    #     :birthday,
    #     birthday.each do |birthymd|

    #   )
    # end

    def birthday_join
      # パラメータ取得
      # date = params[:user][:birthday]
      date = params[:birthday]
  
      # ブランク時のエラー回避のため、ブランクだったら何もしない
      if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
        return
      end
  
      # 年月日別々できたものを結合して新しいDate型変数を作って返す
      Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
  
    end

end
