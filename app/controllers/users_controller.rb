class UsersController < ApplicationController

  def mypage

  end

  def destroy

  end

  def person_info
    @user = User.find(current_user.id)
    @prefectures = Prefecture.all
  end

end
