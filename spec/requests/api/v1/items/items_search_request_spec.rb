require 'rails_helper'

RSpec.describe 'Items search endpoints' do
  describe 'Single finders' do
    before :each do
      create_list(:item, 4)
      @found_item_1 = Item.first
      @found_item_2 = create(:item, name: "Find Me")
    end

    it 'Can find a single item by its id' do
      get "/api/v1/items/find?id=#{@found_item_1.id}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_item_1.id.to_s)
      expect(search_results_json[:data][:type]).to eq("item")
      expect(search_results_json[:data]).to have_key(:attributes)
      expect(search_results_json[:data][:attributes]).to have_key(:name)
      expect(search_results_json[:data][:attributes]).to have_key(:description)
      expect(search_results_json[:data][:attributes]).to have_key(:unit_price)
      expect(search_results_json[:data][:attributes]).to have_key(:merchant_id)
    end

    it 'Can find a single item by its full name' do
      get "/api/v1/items/find?id="
    end

    it 'Can find a single item by a fragment of its name' do

    end

    it 'Can find a single item by description' do

    end

    it 'Can find a single item by price' do

    end

    it 'Can find a single item by the date it was created' do

    end

    it 'Can find a single item by the date it was updated' do

    end
  end
end
