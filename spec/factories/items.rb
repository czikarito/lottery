FactoryGirl.define do
  factory :item do
    name { FFaker::Product.product_name }
    description { FFaker::Lorem.paragraphs.join("\n") }
  end
end
