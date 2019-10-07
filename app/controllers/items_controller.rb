class ItemsController < ApplicationController

  def sell
    @item = Item.new
    @item.images.build
    @category = Category.find(1)
    @burden = Burden.roots
    @prefectures = Prefecture.all
  end

  def create
    @item = Item.new(item_params)
    # ユーザー登録機能とマージ次第、current_userを含むコードを使用すること
    # @item.build_transact(seller_id: current_user.id)
    @item.build_transact(seller_id: 1)
    if @item.save
      redirect_to root_path
    else
      render :sell
    end
  end

  def deteal

  end

  private
  def item_params
    # ユーザー登録機能とマージ次第、current_userを含むコードを使用すること
    # params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: current_user.id, torihiki_info: 0)
    params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: 1, torihiki_info: 0)
  end

end
