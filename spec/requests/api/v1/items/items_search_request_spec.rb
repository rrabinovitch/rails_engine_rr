require 'rails_helper'

RSpec.describe 'Items search endpoints' do
  describe 'Single finders' do
    before :each do
      create_list(:item, 4, created_at: "2012-03-27 14:53:59", updated_at: "2012-04-15 14:00:05")
      @found_item_1 = Item.first
    end

    it 'Can find a single item by its id' do
      get "/api/v1/items/find?id=#{@found_item_1.id}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    it 'Can find a single item by its full name' do
      get "/api/v1/items/find?name=#{@found_item_1.name}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    it 'Can find a single item by a fragment of its name, insensitive to case' do
      search_value = @found_item_1.name[2..6].upcase
      get "/api/v1/items/find?name=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    it 'Can find a single item by description fragment' do
      search_value = @found_item_1.description[12..21]
      get "/api/v1/items/find?description=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    it 'Can find a single item by price' do
      get "/api/v1/items/find?unit_price=#{@found_item_1.unit_price}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    xit 'Can find a single item by the date it was created' do
      get "/api/v1/items/find?created_at=#{@found_item_1.created_at}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end

    xit 'Can find a single item by the date it was updated' do
      get "/api/v1/items/find?updated_at=#{@found_item_1.updated_at}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_item_1.name)
      expect(search_results_json[:data][:attributes][:description]).to eq(@found_item_1.description)
      expect(search_results_json[:data][:attributes][:unit_price]).to eq(@found_item_1.unit_price)
      expect(search_results_json[:data][:attributes][:merchant_id]).to eq(@found_item_1.merchant_id)
    end
  end
end
