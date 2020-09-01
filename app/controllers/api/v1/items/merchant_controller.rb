class Api::V1::Items::MerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.new(Merchant.find(item.merchant.id))
  end
end
