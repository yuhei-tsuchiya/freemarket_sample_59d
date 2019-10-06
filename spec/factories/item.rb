FactoryBot.define do

  factory :item do
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
  end
end
