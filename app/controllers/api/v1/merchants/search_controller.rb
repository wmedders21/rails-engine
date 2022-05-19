class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant.name_search(search_params[:name])
    render json: MerchantSerializer.new(merchants)    
  end

  def show
    merchant = Merchant.name_search(search_params[:name]).first
    render json: MerchantSerializer.new(merchant)
  end

  private
  def search_params
    params.permit(:name)
  end
end
