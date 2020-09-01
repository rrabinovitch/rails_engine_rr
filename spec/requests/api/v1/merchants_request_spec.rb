require 'rails_helper'

RSpec.describe 'Merchants endpoints' do
  it 'Merchants#index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchants_json[:data].count).to eq(3)
    expect(merchants_json[:data].first).to have_key(:id)
    expect(merchants_json[:data].first[:type]).to eq("merchant")
    expect(merchants_json[:data].first).to have_key(:attributes)
    expect(merchants_json[:data].first[:attributes]).to have_key(:name)
    expect(merchants_json[:data].first).to have_key(:relationships)
  end

  it 'Merchants#show' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_json[:data][:id]).to eq(id.to_s)
    expect(merchant_json[:data]).to have_key(:id)
    expect(merchant_json[:data][:type]).to eq("merchant")
    expect(merchant_json[:data]).to have_key(:attributes)
    expect(merchant_json[:data][:attributes]).to have_key(:name)
    expect(merchant_json[:data]).to have_key(:relationships)
  end

  it 'Merchants#create' do
    merchant_params = { name: "Fun Store" }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/merchants", params: JSON.generate({merchant: merchant_params}), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = Merchant.last
    expect(merchant.name).to eq(merchant_params[:name])

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data][:id]).to eq(merchant.id.to_s)
    expect(json_response[:data][:type]).to eq("merchant")
    expect(json_response[:data][:attributes][:name]).to eq(merchant_params[:name])
    expect(json_response[:data]).to have_key(:relationships)
  end

  it 'Merchants#update' do

  end

  it 'Merchants#destroy' do

  end
end
