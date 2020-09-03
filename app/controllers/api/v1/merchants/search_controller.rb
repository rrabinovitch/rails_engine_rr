class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if params[:id]
      item = Merchant.find_by("#{attribute}": search_value)
    # elsif params[:created_at] || params[:updated_at]
    #   LOGIC FOR FINDING ITEM BY CREATED_AT AND UPDATED_AT ATTRIBUTES
    else
      item = Merchant.find_by("#{attribute} ILIKE '%#{search_value}%'")
    end
    render json: MerchantSerializer.new(item)
  end

  private

  def attribute
    request.query_parameters.keys.first
  end

  def search_value
    request.query_parameters.values.first
  end
end
