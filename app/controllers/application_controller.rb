class ApplicationController < ActionController::Base
  # Basic認証(basic_auth, production?)
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth_user && password == Rails.application.credentials.basic_auth_password
    end
  end
end
