require 'rails_helper'

describe 'Items endpoints' do
  it 'Items#index' do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it 'Items#show' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it 'Items#create' do
    merchant = create(:merchant)
    item_params = { name: "Cheap item", description: "This is just a cheap item.", unit_price: 2.75, merchant_id: merchant.id }
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/v1/items", params: JSON.generate({item: item_params}), headers: headers

    expect(response).to be_successful

    item = Item.last
    expect(item.name).to eq(item_params[:name])
  end
end
