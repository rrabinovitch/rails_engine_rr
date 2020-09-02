class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end
end
