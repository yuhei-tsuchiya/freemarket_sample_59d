FactoryBot.define do

  factory :transact do
    # id        {1}
    seller_id {1}
    buyer_id {1}
    item_id {1}
    # association: item
  end
end
