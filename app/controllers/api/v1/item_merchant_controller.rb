class Api::V1::ItemMerchantController < ApplicationController
  def index
    item = Item.find_by_id(params[:item_id])
    render json: MerchantSerializer.new(item.merchant)
  end
end
