# README

## DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false, min-length: 7|
|lastname_kanji|string|null: false|
|firstname_kanji|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|birthday|integer|null: false|
|cellphone_number|string|null: false|
|phone_credential|integer||
|address_id|integer|null: false, foreign_key: true|
|introduction|text||
### Association
- has_many :items
- has_one :address
- has_many :buyer_transacts, class_name: 'Transacts', foreign_key: 'buyer_id'
- has_many :seller_transacts, class_name: 'Transacts', foreign_key: 'seller_id'
## addressesテーブル
|zip_code|string|null: false|
|------|----|-------|
|prefecture_id|string|null: false, foreign_key: true|  ※ 住所の都道府県
|jusho_shikuchoson|string|null: false|
|jusho_banchi|string|null: false|
|jusho_tatemono|string|null: false|
|phone_number|string||

### Association
- belongs_to :user
- belongs_to_active_hash :prefecture  ※Gem active_hashを使用して都道府県を取得

## create_credit_cardsテーブル(Gem PAYJPの仕様に準拠)
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false|
|card_id|string|null: false|
|user_id|integer|null: false, foreign_key: true|

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|good|integer||
|torihiki_info|integer|null: false|  ※ 0:出品中 1:取引中 2:売却済
|product_state|int|null: false|  ※ 0:新品 1:未使用 2:傷なし 3:やや傷あり 4:やや傷汚れ 5:傷汚れ 6:状態悪し
|description|text|null: false|
|shipping_days|int|null: false|  ※ 0:1~2日 1:2~3日 2:4~7日
|user_id|integer|null: false, foreign_key: true|
|category_id|int|null: false, foreign_key: true|  ※ 多階層カテゴリ(Gem ancestry)を使用
|size_id|int|null: false, foreign_key: true|  ※ 多階層カテゴリ(Gem ancestry)を使用
|burden_id|integer|null: false, foreign_key: true|    ※ 多階層カテゴリ(Gem ancestry)を使用
|prefecture_id|integer|null: false, foreign_key: true|  ※ 発送元
### Association
- has_many :images
- has_many :comments
- belongs_to :user
- belongs_to :category
- belongs_to :size
- belongs_to :burden
- belongs_to_active_hash :prefecture  ※Gem active_hashを使用して都道府県を取得
- has_one    :transaction

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text||
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## categorysテーブル  ※カテゴリー×3、ブランドを含む
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
|size_id|int|null: false, foreign_key: true|  ※ 多階層カテゴリ(Gem ancestry)を使用
### Association
- has_many :items
- has_ancestry
- belongs_to :size

## sizesテーブル  ※サイズを含む
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :category
- has_many :items
- has_ancestry

## burdensテーブル  ※配送料の負担、配送の方法を含む
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :items
- has_ancestry

## transactsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true|
|seller_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :buyer, class_name 'User', foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key:  'seller_id'












































































