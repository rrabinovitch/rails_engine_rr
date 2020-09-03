class Api::V1::Items::SearchController < ApplicationController
  def show
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
