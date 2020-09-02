require 'rails_helper'

RSpec.describe 'Item Merchant endpoint' do
  it 'returns the merchant associated with an item' do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(item_merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(item_merchant_json[:data][:type]).to eq("merchant")
    expect(item_merchant_json[:data][:attributes][:name]).to eq(merchant.name)
    # expect(item_merchant_json[:data][:relationships][:items][:data].first[:id]).to eq(item.id.to_s)
  end
end
