FactoryBot.define do

  factory :image do
    id     {1}
    # image  {"test.jpg"}  # {File.open("#{Rails.root}/public/images/test.jpg")}
    image   {File.open("#{Rails.root}/public/images/test.jpg")}
    association :item
  end
end
