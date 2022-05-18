class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find_by_id(params[:merchant_id])
    if merchant
      render json: ItemSerializer.new(merchant.items)
    else
      render json: { status: "Not Found", code: 404, message: 'merchant not found' }, status: 404
    end
  end
end
