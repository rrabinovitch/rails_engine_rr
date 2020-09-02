require 'rails_helper'

RSpec.describe 'Items search endpoints' do
  before :each do
    create_list(:item, 4, created_at: "2012-03-27 14:53:59", updated_at: "2012-04-15 14:00:05")
    @found_item = Item.first
  end

  describe 'Single finders' do
    it 'Can find a single item by its id' do
      get "/api/v1/items/find?id=#{@found_item.id}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    it 'Can find a single item by its full name, insensitive to case' do
      get "/api/v1/items/find?name=#{@found_item.name.upcase}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    it 'Can find a single item by a fragment of its name, insensitive to case' do
      search_value = @found_item.name[2..6].upcase
      get "/api/v1/items/find?name=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    it 'Can find a single item by description fragment' do
      search_value = @found_item.description[12..21]
      get "/api/v1/items/find?description=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    it 'Can find a single item by price' do
      get "/api/v1/items/find?unit_price=#{@found_item.unit_price}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    xit 'Can find a single item by the date it was created' do
      get "/api/v1/items/find?created_at=#{@found_item.created_at}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end

    xit 'Can find a single item by the date it was updated' do
      get "/api/v1/items/find?updated_at=#{@found_item.updated_at}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item.merchant_id)
    end
  end

  describe 'Multi-finders' do
    it 'Can find set of items by full name, insensitive to case' do
      get "/api/v1/items/find_all?name=#{@found_item.name.upcase}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data].count).to eq(4)
      expect(search_results_json[:data].first).to have_key(:id)
      expect(search_results_json[:data].first[:type]).to eq("item")
      expect(search_results_json[:data].first).to have_key(:attributes)
      expect(search_results_json[:data].first[:attributes]).to have_key(:name)
      expect(search_results_json[:data].first[:attributes]).to have_key(:description)
      expect(search_results_json[:data].first[:attributes]).to have_key(:unit_price)
      expect(search_results_json[:data].first[:attributes]).to have_key(:merchant_id)
    end

    it 'Can find set of items by name fragment, insensitive to case' do
      search_value = @found_item.name[2..6].upcase
      get "/api/v1/items/find_all?name=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data].count).to eq(4)
      expect(search_results_json[:data].first).to have_key(:id)
      expect(search_results_json[:data].first[:type]).to eq("item")
      expect(search_results_json[:data].first).to have_key(:attributes)
      expect(search_results_json[:data].first[:attributes]).to have_key(:name)
      expect(search_results_json[:data].first[:attributes]).to have_key(:description)
      expect(search_results_json[:data].first[:attributes]).to have_key(:unit_price)
      expect(search_results_json[:data].first[:attributes]).to have_key(:merchant_id)
    end
  end
end
