FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { "123456789098765" }
    credit_card_expiration_date { "2020-08-30" }
    result { "success" }
  end
end
