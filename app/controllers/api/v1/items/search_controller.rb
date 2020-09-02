class Api::V1::Items::SearchController < ApplicationController
  def show
    # if there's more than one query param or if the first attribute is not one of our model attributes, send an error
    # refactor into Item.find_by_attribute(attribute, search_value) class method in model file
      # model method can identify whether to search for id/unit_price or other attributes
      # OR refactor into filter_by method that can be used for both single and multi-finders
        # and just call .first on the return value for #show action
    if params[:id] || params[:unit_price]
      item = Item.find_by("#{attribute}": search_value)
    # elsif params[:created_at] || params[:updated_at]
    #   LOGIC FOR FINDING ITEM BY CREATED_AT AND UPDATED_AT ATTRIBUTES
    else
      item = Item.find_by("#{attribute} ILIKE '%#{search_value}%'")
    end
    render json: ItemSerializer.new(item)
  end

  def index
    if params[:unit_price]
      items = Item.where("#{attribute}": search_value)
    elsif
      items = Item.where("#{attribute} ILIKE '%#{search_value}%'")
    end
    render json: ItemSerializer.new(items)
  end

  private

  def attribute
    request.query_parameters.keys.first
  end

  def search_value
    request.query_parameters.values.first
  end
end

# dont worry abotu partial matches for ids and prices
# dates can be changed to string
