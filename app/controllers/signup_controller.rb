class SignupController < ApplicationController

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
    session[:birthday]              = user_params[:birthday]
    @user = User.new # 新規インスタンス作成
  end

  def step3
    # step2で入力された値をsessionに保存
    session[:cellphone_number]      = user_params[:cellphone_number]
    @user = User.new # 新規インスタンス作成
  end

  # def step4
  #   # step3で入力された値をsessionに保存
  #   session[:cellphone_number]
  #   @user = User.new # 新規インスタンス作成
  # end

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
    )
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
        :birthday,
        :cellphone_number
      )
    end

end
