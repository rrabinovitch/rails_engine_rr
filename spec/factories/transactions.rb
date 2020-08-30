FactoryBot.define do
  factory :transaction do
    invoice { "" }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2020-08-30" }
    result { 1 }
  end
end
