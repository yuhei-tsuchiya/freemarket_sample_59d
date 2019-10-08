class ItemsController < ApplicationController

  def index
    @items = Item.all.limit(10)
  end

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
    @item.build_transact(seller_id: 2)
    if @item.save
      redirect_to root_path
    else
      @item.images = []
      @item.images.build
      @category = Category.find(1)
      @burden = Burden.roots
      @prefectures = Prefecture.all
      render :sell
    end
  end

  def show
    @items = Item.find(params[:id])
    @images = @items.images
  end

  def edit
    @item = Item.find(params[:id])
    @image = Image.new
    # @item.images.build
    # cat = @item.category
    # @category_now = [cat.parent.parent, cat.parent, cat]
    @category = Category.find(1)
    @burden = Burden.roots
    @prefectures = Prefecture.all
  end

  def update
    binding.pry
    @item = Item.find(params[:id])
    image_del_list = delete_images if delete_images
    image_update_list = item_params[:images_attributes] if item_params[:images_attributes]
    update_params = item_params
    update_params.delete(:images_attributes)
    if @item.update(update_params)
        if image_update_list
          image_update_list.each do |img|
            Image.create(img.merge(item_id: @item.id))
            # Image.create(img.merge(user_id: current_user.id))
          end
        end
        if image_del_list
          image_del_list.each do |image_id|
          Image.find(image_id).destroy
        end
      end
      redirect_to item_path(params[:id])
    else
      # redirect_to edit_item_path(params[:id])
      @category = Category.find(1)
      @burden = Burden.roots
      @prefectures = Prefecture.all
      render :edit
    end
  end

  def buy

  end

  def deteal

  end

  private
  def item_params
    # ユーザー登録機能とマージ次第、current_userを含むコードを使用すること
    # params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: current_user.id, torihiki_info: 0)
    params.require(:item).permit(:name, :description, :category_id, :size_id, :brand_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: 2, torihiki_info: 0)
  end

  def delete_images
    if params.has_key?(:delete_ids)
      return params.require(:delete_ids)
    else
      return nil
    end
  end

end
