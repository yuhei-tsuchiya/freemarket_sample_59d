class RegistrationsController < ApplicationController

  password = Devise.friendly_token.first(7)
  if session[:provider].present? && session[:uid].present?
    @user = User.create(nickname:session[:nickname], email: session[:email], password: "password", password_confirmation: "password", f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], lastname_kanji: session[:lastname_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
    sns = SnsCredential.create(user_id: @user.id,uid: session[:uid], provider: session[:provider])
  else
    @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], lastname_kanji: session[:lastname_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
  end
  
end
