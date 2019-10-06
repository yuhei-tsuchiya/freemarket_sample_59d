FactoryBot.define do

  factory :image do
    image  {"test.jpg"}  # {File.open("#{Rails.root}/public/images/test.jpg")}
    item_id  {1}
  end
end
