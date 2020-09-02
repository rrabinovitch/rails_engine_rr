class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:id]
      item = Item.find(params[:id])
    elsif params[:name]
      item = Item.find_by(name: params[:name])
    end
    render json: ItemSerializer.new(item)
  end
end
