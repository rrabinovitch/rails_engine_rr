require 'rails_helper'

RSpec.describe 'Merchants search endpoints' do
  before :each do
    create_list(:merchant, 4, created_at: "2012-03-27 14:53:59", updated_at: "2012-04-15 14:00:05")
    @found_merchant = Merchant.first
    @not_found_merchant = create(:merchant, name: "Don't Find Me")
  end

  describe 'Single finders' do
    it 'Can find a single merchant by its id' do
      get "/api/v1/merchants/find?id=#{@found_merchant.id}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_merchant.id.to_s)
      expect(search_results_json[:data][:type]).to eq("merchant")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_merchant.name)
    end

    it 'Can find a single merchant by its full name, insensitive to case' do
      get "/api/v1/merchants/find?name=#{@found_merchant.name.upcase}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_merchant.id.to_s)
      expect(search_results_json[:data][:type]).to eq("merchant")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_merchant.name)
    end
  end
end
