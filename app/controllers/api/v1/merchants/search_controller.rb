class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if params[:id]
      merchant = Merchant.find_by("#{attribute}": search_value)
    # elsif params[:created_at] || params[:updated_at]
    #   LOGIC FOR FINDING MERCHANT BY CREATED_AT AND UPDATED_AT ATTRIBUTES
    else
      merchant = Merchant.find_by("#{attribute} ILIKE '%#{search_value}%'")
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where("#{attribute} ILIKE '%#{search_value}%'")
    render json: MerchantSerializer.new(merchants)
  end

  private

  def attribute
    request.query_parameters.keys.first
  end

  def search_value
    request.query_parameters.values.first
  end
end
