class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = request.query_parameters.keys.first
    search_value = request.query_parameters.values.first
    # if there's more than one query param or if the first attribute is not one of our model attributes, send an error
    # refactor into Item.find_by_attribute(attribute, search_value) class method in model file
      # model method can identify whether to search for id/unit_price or other attributes
    if params[:id] || params[:unit_price]
      item = Item.find_by("#{attribute}": search_value)
    # elsif params[:created_at] || params[:updated_at]
    #   binding.pry
    else
      item = Item.find_by("#{attribute} ILIKE '%#{search_value}%'")
    end
    render json: ItemSerializer.new(item)
  end
end

# dont worry abotu partial matches for ids and prices
# dates can be changed to string
