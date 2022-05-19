class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    merchant = Merchant.find_by_id(params[:id])
    if merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: { error: "Not Found" }, status: 404
    end
  end
end
