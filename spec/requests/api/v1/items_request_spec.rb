require 'rails_helper'

RSpec.describe 'Items endpoints' do
  it 'Items#index' do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    items_json = JSON.parse(response.body, symbolize_names: true)
    expect(items_json[:data].count).to eq(3)
    expect(items_json[:data].first).to have_key(:id)
    expect(items_json[:data].first[:type]).to eq("item")
    expect(items_json[:data].first).to have_key(:attributes)
    expect(items_json[:data].first[:attributes]).to have_key(:name)
    expect(items_json[:data].first[:attributes]).to have_key(:description)
    expect(items_json[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_json[:data].first[:attributes]).to have_key(:merchant_id)
    # expect(items_json[:data].first).to have_key(:relationships)
  end

  it 'Items#show' do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_json = JSON.parse(response.body, symbolize_names: true)
    expect(item_json[:data][:id]).to eq(id.to_s)
    expect(item_json[:data]).to have_key(:id)
    expect(item_json[:data][:type]).to eq("item")
    expect(item_json[:data]).to have_key(:attributes)
    expect(item_json[:data][:attributes]).to have_key(:name)
    expect(item_json[:data][:attributes]).to have_key(:description)
    expect(item_json[:data][:attributes]).to have_key(:unit_price)
    expect(item_json[:data][:attributes]).to have_key(:merchant_id)
    # expect(item_json[:data]).to have_key(:relationships)
  end

  it 'Items#create' do
    merchant = create(:merchant)
    item_params = { name: "Cheap item", description: "This is just a cheap item.", unit_price: 2.75, merchant_id: merchant.id }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", params: item_params#, headers: headers
    # post "/api/v1/items", params: JSON.generate({item: item_params}), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item = Item.last
    expect(item.name).to eq(item_params[:name])

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data][:id]).to eq(item.id.to_s)
    expect(json_response[:data][:type]).to eq("item")
    expect(json_response[:data][:attributes][:name]).to eq(item_params[:name])
    expect(json_response[:data][:attributes][:description]).to eq(item_params[:description])
    expect(json_response[:data][:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(json_response[:data][:attributes][:merchant_id]).to eq(item_params[:merchant_id])

    # expect(json_response[:data]).to have_key(:relationships)
  end

  it 'Items#update' do
    item_id = create(:item).id
    previous_name = Item.last.name
    update_item_params = { name: "New Item Name" }
    headers = { "CONTENT_TYPE" => "application/json" }

    put "/api/v1/items/#{item_id}", params: update_item_params#, headers: headers

    # put "/api/v1/items/#{item_id}", params: JSON.generate({item: update_item_params}), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item = Item.find_by(id: item_id)

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(update_item_params[:name])

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data][:id]).to eq(item_id.to_s)
    expect(json_response[:data][:type]).to eq("item")
    expect(json_response[:data][:attributes][:name]).to eq(update_item_params[:name])
  end

  it 'Items#destroy' do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
