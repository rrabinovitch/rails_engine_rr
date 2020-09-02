class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = request.query_parameters.keys.first
    search_value = request.query_parameters.values.first
    # if there's more than one query param or if the first attribute is not one of our model attributes, send an error
    if params[:id]
      item = Item.find(params[:id])
    else
      item = Item.where("#{attribute} ILIKE '%#{search_value}%'").first
    end
    render json: ItemSerializer.new(item)
  end
end

# dont worry abotu partial matches for ids and prices
# dates can be changed to string
