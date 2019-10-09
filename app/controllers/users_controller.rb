class UsersController < ApplicationController

  def mypage

  end

  def destroy

  end

  def new
 
  end
    
  def person_info
    @user = User.find(current_user)
    @prefectures = Prefecture.all
  end

end
