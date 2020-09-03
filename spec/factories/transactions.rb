FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { "123456789098765" }
    result { "success" }
  end
end
