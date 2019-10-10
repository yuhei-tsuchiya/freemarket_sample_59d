class UsersController < ApplicationController

  def mypage

  end

  def destroy

  end

  def new
 
  end
    
  def person_info

    @prefectures = Prefecture.all
  end

end
