class Api::V1::Items::SearchController < ApplicationController
  def show
    attribute = request.query_parameters.keys.first
    search_value = request.query_parameters.values.first
    item = Item.where("lower(#{attribute}) LIKE '%#{search_value.downcase}%'").first
    # if params[:id]
    #   item = Item.find(params[:id])
    # elsif params[:name]
    #   item = Item.find_by(name: params[:name])
    # end
    render json: ItemSerializer.new(item)
  end
end


# attribute = request.query_parameters.keys.first
  # => "name"
# search_value = request.query_parameters.values.first
  # => "Fin"
# Item.where("name LIKE '%Fin%'")
