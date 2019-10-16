class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]
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
    if @item.user == current_user
      @image = Image.new
    else
      redirect_to item_path(params[:id])
    end
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
    if @item.user == current_user
      redirect_to item_path(params[:id])
    else
      @user = @item.user
      @card = Card.new
    end
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

  def category
    @selected_cat = Category.find(params[:id])
    items = Item.all
    @items = []
    # 第1カテゴリー(レディース、メンズ、etc)
    if @selected_cat.depth == 1
      cat_list = @selected_cat.indirect_ids
    # 第2カテゴリー
    elsif @selected_cat.depth == 2
      cat_list = @selected_cat.child_ids
    # 第3カテゴリー
    elsif @selected_cat.depth == 3
      cat_list = [@selected_cat.id]
    end
    items.each do |item|
      if cat_list.include?(item.category_id)
        @items << item
      end
    end
  end

  def search
    search_params = top_search_params == nil ? params[:q] : top_search_params
    @q = Item.ransack(search_params)
    @category = Category.find(1)
    @size = Size.find(1)   # 服サイズ
    @lists = Item.new
    @items = @q.result(distinct: true).includes(:burden)
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

  def top_search_params
    if params.has_key?(:name_cont)
      params.slice(:name_cont)
    else
      return nil
    end
  end

end

