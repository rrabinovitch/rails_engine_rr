require 'rails_helper'

RSpec.describe 'Item Merchant endpoint' do
  it 'returns the merchant associated with an item' do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(item_merchant_json[:data].count).to eq(1)
    # expect(item_merchant_json[:data])
  end
end
