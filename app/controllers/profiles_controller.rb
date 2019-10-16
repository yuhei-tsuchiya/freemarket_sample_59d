class ProfilesController < ApplicationController
  before_action :move_to_root_path, only: [:show, :edit, :edit2, :update]
  before_action :set_user, only: [:show, :edit, :edit2, :update]

  def show
  end

  def edit
  end

  def edit2
    @prefectures = Prefecture.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:nickname, :introduction))
    flash[:notice] = "プロフィール情報が変更されました"
    redirect_to edit_profile_path
  end

  private
  def move_to_root_path
    if User.find(params[:id]) == current_user
      @user = current_user
    else
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
