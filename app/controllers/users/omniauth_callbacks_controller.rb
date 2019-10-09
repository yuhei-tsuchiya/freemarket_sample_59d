class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = User.find_oauth(@omniauth)
    @user = info[:user]
    if @user.persisted? 
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else 
      @sns = info[:sns]
      session[:provider] = @sns[:provider]
      session[:uid] = @sns[:uid]
      render template: "/signup/user_info_input"
    end
  end

  def failure
    redirect_to root_path and return
  end

  # def password
  #   password = Devise.friendly_token.first(7)
  #   if session[:provider].present? && session[:uid].present?
  #     @user = User.create(nickname: session[:nickname], email: session[:email], password: "password", password_confirmation: "password", firstname_kana: session[:firstname_kana],lastname_kana: session[:lastname_kana], lastname_kanji: session[:lastname_kanji], firstname_kana: session[:firstname_kana], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
  #     sns = SnsCredential.create(user_id: @user.id,uid: session[:uid], provider: session[:provider])
  #   else
  #     @user = User.create(nickname: session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], firstname_kana: session[:firstname_kana],lastname_kana: session[:lastname_kana], lastname_kanji: session[:lastname_kanji], firstname_kana: session[:firstname_kana], birthday: session[:birthday], cellphone_number: session[:cellphone_number])
  #   end
  # end

end