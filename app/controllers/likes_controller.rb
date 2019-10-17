class LikesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def create
    @like = current_user.likes.create(item_id: params[:item_id])
    @item = Item.all
  end

  def destroy
    like = current_user.likes.find_by(item_id: params[:item_id])
    like.destroy
    @item = Item.all
  end

  private

  def set_item
    @items = Item.find(params[:item_id])
  end
end
