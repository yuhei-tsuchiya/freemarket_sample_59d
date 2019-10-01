class ItemsController < ApplicationController

  def sell
    @item = Item.new
    # 5.times{ @item.images.build }
    @item.images.build
    @category = Category.find(1)
    @burden = Burden.roots
    @prefectures = Prefecture.all
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        item_params[:images_attributes].each do |image|
          @item.images.create(image: image['image'], item_id: @item.id)
        end
      format.html{redirect_to root_path}
      else
        @item.images.build
        @category = Category.find(1)
        @burden = Burden.roots
        @prefectures = Prefecture.all
        format.html{render action: "sell"}
      end
    end
  end

  def deteal

  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :product_state, :burden_id, :prefecture_id, :shipping_days, :price, images_attributes: [:image] ).merge(good: 0, user_id: 1, torihiki_info: 0)
  end

end

  # itemレコードの保存方法(コンソールで確認)
  # $ rails c
  # > item = Item.create(name: "test", price: 1000, good: 2, torihiki_info: 2, product_state: 1, description: "test desu", shipping_days: 2, user_id: 1, prefecture_id: 3, category_id: 160, size_id: 10, burden_id: 4)
  # => #<Item id: 1, name: "test", price: 1000, good: 2, torihiki_info: 2, product_state: 1, description: "test desu", shipping_days: 2, user_id: 1, created_at: "2019-09-30 01:16:37", updated_at: "2019-09-30 01:16:37", prefecture_id: 3, category_id: 160, size_id: 10, burden_id: 4>

  # itemレコードからアソシエーションメソッド確認
  # > item.category
  # => #<Category id: 160, name: "Tシャツ/カットソー(半袖/袖なし)", created_at: "2019-09-30 01:11:27", updated_at: "2019-09-30 01:11:27", size_id: nil, ancestry: "1/2/15">
  # > item.category.parent
  # => #<Category id: 15, name: "トップス", created_at: "2019-09-30 01:11:26", updated_at: "2019-09-30 01:11:26", size_id: 1, ancestry: "1/2">
  # > item.category.parent.parent.name
  # => "レディース"
  # > item.size
  # => #<Size id: 10, name: "M", created_at: "2019-09-30 01:11:26", updated_at: "2019-09-30 01:11:26", ancestry: "1">
  # > item.burden
  # => #<Burden id: 4, name: "ゆうメール", created_at: "2019-09-30 01:11:29", updated_at: "2019-09-30 01:11:29", ancestry: "1">
  # > item.prefecture
  # => #<Prefecture:0x00007fb4da47dfb0 @attributes={:id=>3, :name=>"岩手県"}>

  # カテゴリーにサイズがあるかどうかの判別方法
  # > cat = Category.find(8)  # コスメ・香水・美容（サイズはない）
  # > cat.size
  # => nil
  # > cat2 = Category.find(15)  # レディース>トップス（サイズあり）
  # > cat2.size
  # => #<Size id: 1, name: "服サイズ", created_at: "2019-09-30 01:11:26", updated_at: "2019-09-30 01:11:26", ancestry: nil>

  # 取引状況、配送日数、商品状態を文字列に変換するメソッド(item.rbで定義)
  # > item.display_torihiki_info
  # => "売却済"
  # > item.display_shipping_days
  # => "4~7日"
  # > item.display_product_state
  # => "未使用"

  # 取引状況、配送日数、商品状態を配列で一覧表示するメソッド(item.rbで定義)
  # > @item = Item.new
  # > @item.torihiki_info_list
  # => ["出品中", "取引中", "売却済"]
  # > @item.shipping_days_list
  # => ["1~2日", "2~3日", "4~7日"]
  # > @item.product_state_list
  # => ["新品", "未使用", "傷なし", "やや傷あり", "やや傷汚れ", "傷汚れ", "状態悪し"]


