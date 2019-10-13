class ProfilesController < ApplicationController
  # before_action :authenticate_user, {only: [:edit, :show]}

  # if User.find(params[:id]) == current_user
  before_action :move_to_root_path,  only:  [:show, :edit, :edit2]

  def show

  end

  def edit
    
  end

  def edit2
    @prefectures = Prefecture.all
  end

  private
  def move_to_root_path
    # # redirect_to action: :index unless user_signed_in?
    # redirect_to root_path unless user_signed_in?

    if User.find(params[:id]) == current_user
      @user = current_user
    else
      redirect_to root_path
    end

  end

end
