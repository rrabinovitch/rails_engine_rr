require 'rails_helper'

RSpec.describe 'Merchant Items endpoint' do
  it 'returns all items associated with a merchant' do
    merchant = create(:merchant)
    3.times {create(:item, merchant: merchant)}
    diff_merchant_item = create(:item)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant_items_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_items_json[:data].count).to eq(3)
    expect(merchant_items_json[:data].first).to have_key(:id)

    expect(merchant_items_json[:data].none? { |item| item[:id] == diff_merchant_item.id }).to eq(true)
  end
end
