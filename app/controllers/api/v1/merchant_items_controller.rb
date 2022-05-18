class Api::V1::MerchantItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.find_by_id(params[:merchant_id]).items)
  end
end
