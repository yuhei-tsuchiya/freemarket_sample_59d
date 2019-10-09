class RegistrationsController < ApplicationController

  password = Devise.friendly_token.first(7)
  if session[:provider].present? && session[:uid].present?
    @user = User.create(nickname:session[:nickname], email: session[:email], password: "password", password_confirmation: "password", firstname_kana: session[:firstname_kana],lastname_kana: session[:lastname_kana], lastname_kanji: session[:lastname_kanji], firstname_kana: session[:firstname_kana], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
    sns = SnsCredential.create(user_id: @user.id,uid: session[:uid], provider: session[:provider])
  else
    @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], firstname_kana: session[:firstname_kana],lastname_kana: session[:lastname_kana], lastname_kanji: session[:lastname_kanji], firstname_kana: session[:firstname_kana], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
  end

  # def create
  #   binding.pry 
  #   if params[:user][:password] == "" #sns登録なら
  #     params[:user][:password] = "Devise.friendly_token.first(6)" #deviseのパスワード自動生成機能を使用
  #     params[:user][:password_confirmation] = "Devise.friendly_token.first(6)"
  #     super
  #     # binding.pry
  #     sns = SnsCredential.update(user_id:  @user.id)
  #   else #email登録なら
  #     # binding.pry
  #     super
  #   end
  # end

end
