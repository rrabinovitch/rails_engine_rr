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

  end

  it 'Merchants#create' do

  end

  it 'Merchants#update' do

  end

  it 'Merchants#destroy' do

  end
end
