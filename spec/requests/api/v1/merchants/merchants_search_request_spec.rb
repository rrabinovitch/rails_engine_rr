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

    it 'Can find a single merchant by a fragment of its name, insensitive to case' do
      search_value = @found_merchant.name[0..2].upcase
      get "/api/v1/merchants/find?name=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_merchant.id.to_s)
      expect(search_results_json[:data][:type]).to eq("merchant")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_merchant.name)
    end

    xit 'Can find a single merchant by the date it was created' do
      get "/api/v1/merchants/find?created_at=#{@found_merchant.created_at}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data][:id]).to eq(@found_merchant.id.to_s)
      expect(search_results_json[:data][:type]).to eq("merchant")
      expect(search_results_json[:data][:attributes][:name]).to eq(@found_merchant.name)
    end
  end

  describe 'Multi-finders' do
    it 'Can find multiple merchants by full name, insensitive to case' do
      get "/api/v1/merchants/find_all?name=#{@found_merchant.name.upcase}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data].count).to eq(4)
      expect(search_results_json[:data].first).to have_key(:id)
      expect(search_results_json[:data].first[:type]).to eq("merchant")
      expect(search_results_json[:data].first).to have_key(:attributes)
      expect(search_results_json[:data].first[:attributes]).to have_key(:name)
    end

    it 'Can find multiple merchants by name fragment, insensitive to case' do
      search_value = @found_merchant.name[0..2].upcase
      get "/api/v1/merchants/find_all?name=#{search_value}"
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_results_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_results_json[:data].count).to eq(4)
      expect(search_results_json[:data].first).to have_key(:id)
      expect(search_results_json[:data].first[:type]).to eq("merchant")
      expect(search_results_json[:data].first).to have_key(:attributes)
      expect(search_results_json[:data].first[:attributes]).to have_key(:name)
    end
  end
end
