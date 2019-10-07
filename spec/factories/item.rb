FactoryBot.define do

  factory :item do
    id                    {1}
    name                  {"test"}
    price                 {1000}
    good                  {2}
    torihiki_info         {2}
    product_state         {1}
    description           {"test"}
    shipping_days         {2}
    prefecture_id         {3}
    user
    category
    size
    burden
    images {[
      FactoryBot.build(:image, item: nil)
    ]}
    after(:build) do |item|
      item.build_transact(item_id: item.id, seller_id: 1, buyer_id: nil)
    end
  end
end
