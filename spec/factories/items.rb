FactoryBot.define do
  factory :item do
    name { "A fancy item" }
  description { "This is a *~very fancy~* item." }
    unit_price { 5.5 }
    merchant
  end
end
