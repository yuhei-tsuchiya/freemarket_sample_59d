class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy]
  before_action :set_ancestry, only: [:sell, :edit]

  def index
    @items = Item.all.limit(10)
  end

  def sell
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.build_transact(seller_id: current_user.id)
    if @item.save
      redirect_to root_path
    else
      @item.images = []
      @item.images.build
      set_ancestry
      render :sell
    end
  end

  def show
    @images = @item.images
  end

  def edit
    @image = Image.new
  end


  def update
    update_params = item_params
    image_del_list = delete_images if delete_images
    image_update_list = update_params[:images_attributes] if update_params[:images_attributes]
    update_params.delete(:images_attributes)
    update_params = update_params.merge(size_id: nil) unless update_params.has_key?(:size_id)
    update_params = update_params.merge(brand_id: nil) unless update_params.has_key?(:brand_id)
    if image_update_list
      image_update_list.each do |img|
        Image.create(img.merge(item_id: @item.id))
      end
    end
    if image_del_list
        image_del_list.each do |image_id|
        Image.find(image_id).destroy
      end
    end
    if @item.update(update_params)
      redirect_to item_path(params[:id])
    else
      set_ancestry
      render :edit
    end
  end

  def buy
    @user = @item.user
    @card = Card.new
  end

  def deteal

  end

  def destroy
    if @item.user == current_user
      if @item.destroy
        redirect_to root_path, notice: '商品を削除しました'
      else
        @images = @item.images
        flash.now[:alert] = "商品削除に失敗しました"
        render :show
      end
    else
      redirect_to item_path(params[:id])
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: current_user.id, torihiki_info: 0)
  end

  def delete_images
    if params.has_key?(:delete_ids)
      return params.require(:delete_ids)
    else
      return nil
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_ancestry
    @category = Category.find(1)
    @burden = Burden.roots
    @prefectures = Prefecture.all
  end

  def pay
    Payjp.api_key = 'sk_test_6da54b4ed1e7123d5e996bbb'
    charge = Payjp::Charge.create(
    :amount => @product.price,
    :card => params['payjp-token'],
    :currency => 'jpy',
)
end


def set_item
  @item = Item.find(params[:id])
end

end

